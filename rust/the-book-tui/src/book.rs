use crossterm::{execute, terminal};
use indicatif::ProgressBar;
use itertools::Itertools;
use reqwest::{blocking::Client, header::HeaderMap};
use serde::Deserialize;
use std::{
    fs::{self, File},
    io::{self, Write},
    path::PathBuf,
};
pub type Result<T> = std::result::Result<T, Box<dyn std::error::Error>>;
static RUST_KEYWORDS: [&str; 52] = [
    "as", "async", "await", "break", "const", "continue", "crate", "dyn", "else", "enum", "extern",
    "false", "fn", "for", "if", "impl", "in", "let", "loop", "match", "mod", "move", "mut", "pub",
    "ref", "return", "Self", "self", "static", "struct", "super", "trait", "true", "type", "union",
    "unsafe", "use", "where", "while", "abstract", "become", "box", "do", "final", "macro",
    "override", "priv", "try", "typeof", "unsized", "virtual", "yield",
];

#[derive(Deserialize, Debug)]
pub struct GitHubFile {
    pub path: String,
}

impl GitHubFile {
    fn to_rawfile_link(&self) -> String {
        let mut base = String::from("https://raw.githubusercontent.com/rust-lang/book/main/");
        base.push_str(self.path.as_str());
        base
    }
}

#[derive(Deserialize)]
struct GithubResponse {
    tree: Vec<GitHubFile>,
}

fn book_dir() -> PathBuf {
    match home::home_dir() {
        Some(path) => path.join(".the-book-tui/book"),
        None => {
            panic!("Impossible to get your home dir! Please set your $HOME environment variable.")
        }
    }
}

pub fn path_to_title(path: &PathBuf) -> String {
    let raw_title = path
        .file_stem()
        .unwrap()
        .to_os_string()
        .to_str()
        .unwrap()
        .to_string();
    let pieces = raw_title.split('-').collect::<Vec<&str>>();
    let capitalized_pieces = pieces
        .iter()
        .map(|w| w.to_string().remove(0).to_uppercase().to_string() + &w[1..])
        .collect::<Vec<String>>();
    capitalized_pieces.join(" ")
}

// A paragraph is defined as content after and including a
// line that stars with a '#' until the next such line.
pub fn parse_file_into_parapgraphs(file_contents: &String) -> Vec<MarkdownParagraph> {
    let mut paragraphs: Vec<MarkdownParagraph> = Vec::new();

    let mut paragraph_contents = "".to_string();
    for line in file_contents.lines() {
        // Second condition is to exclude derive macro samples
        // TODO: Make this better
        if line.starts_with('#') && !line.contains('[') {
            paragraphs.push(MarkdownParagraph {
                contents: paragraph_contents,
                relevancy: 0,
            });
            paragraph_contents = "".to_string();
        } else {
            paragraph_contents += &(line.to_owned() + "\n");
        }
    }

    paragraphs
}

#[derive(Clone)]
pub struct MarkdownFile {
    pub path: PathBuf,
    pub contents: String,
    pub title: String,
    pub relevancy: u64,
    pub paragraphs: Vec<MarkdownParagraph>,
}

#[derive(Clone)]
pub struct MarkdownParagraph {
    pub contents: String,
    pub relevancy: u64,
}

impl MarkdownFile {
    pub fn new_from_path(path: PathBuf) -> Self {
        let title = path_to_title(&path);
        let contents = fs::read_to_string(path.clone())
            .unwrap_or_else(|_| panic!("Could not read the file {}", title));
        let paragraphs = parse_file_into_parapgraphs(&contents);

        Self {
            path,
            contents,
            title,
            relevancy: 0,
            paragraphs,
        }
    }

    pub fn search(mut self, search_phrase: &str) -> Self {
        self.paragraphs = self
            .paragraphs
            .iter_mut()
            .map(|p| p.clone().search(search_phrase))
            .collect();

        self.paragraphs
            .sort_by(|a, b| b.relevancy.cmp(&a.relevancy));

        self.set_relevancy();
        self
    }

    pub fn set_relevancy(&mut self) {
        self.relevancy = self.paragraphs.iter().fold(0, |acc, x| acc + x.relevancy);
    }
}

impl MarkdownParagraph {
    // If any of these lines contain the search word, then
    // the paragraph is considered relevant. The key of each entry is the title.
    // Relevancy is the number returned by `count_word` for a paragraph.
    pub fn search(mut self, needle: &str) -> Self {
        let haystack = &self.contents;
        let mut relevancy = 0;

        let words = needle.split(' ').collect::<Vec<&str>>();

        let mut combinations = Vec::new();

        // This ensures that for searches longer than 3 words
        // We're not considering a lot of permutations.
        // Also helps to be more precise.
        let min_combs = words.len().checked_sub(3).unwrap_or(1);
        let max_combs = words.len() + 1;
        for k in min_combs..max_combs {
            let combs = words.iter().combinations(k);
            for c in combs {
                let combination = c
                    .iter()
                    .map(|w| w.to_string())
                    .join(" ")
                    .to_lowercase()
                    .trim()
                    .to_string();

                // This check might be unnecessary
                if !combinations.contains(&combination) {
                    combinations.push(combination);
                }
            }
        }

        for comb in combinations {
            if haystack.contains(&comb) {
                // Longer matches are more valuable
                let needle_size_multiplier = (comb.split(' ').count() as u64).pow(5);

                // If the permutation is a reserved rust keyword it is more likely
                // to be relevant to what the user is searching for
                let keyword_multiplier = if RUST_KEYWORDS.contains(&comb.as_str()) {
                    10
                } else {
                    1
                };

                // One occurence is worth one relevancy
                let count_relevancy = haystack.matches(&comb).count() as u64;

                // If the match is in a title, then we value it more
                let title = haystack.lines().next().unwrap_or_default();
                let title_relevancy = 25 * title.matches(&comb).count() as u64;

                relevancy += keyword_multiplier
                    * needle_size_multiplier
                    * (count_relevancy + title_relevancy);
            }
        }

        self.relevancy = relevancy;
        self
    }
}

fn get_markdown_pages() -> Result<Vec<MarkdownFile>> {
    let mut entries = fs::read_dir(book_dir())?
        .map(|res| res.map(|e| e.path()))
        .collect::<std::result::Result<Vec<_>, io::Error>>()?;

    entries.sort();

    Ok(entries
        .iter()
        .filter(|path| !path.is_dir())
        .map(|file_path| MarkdownFile::new_from_path(file_path.clone()))
        .collect::<Vec<MarkdownFile>>())
}

pub fn read_the_book() -> Result<Vec<MarkdownFile>> {
    if book_dir().is_dir() {
        return get_markdown_pages();
    }

    println!("Book not found. Downloading...");

    let mut headers = HeaderMap::new();
    headers.insert("User-Agent", "the-book-tui".parse().unwrap());

    let client = Client::new();
    let  git_tree = client.get("https://api.github.com/repos/rust-lang/book/git/trees/21a2ed14f4480dab62438dcc1130291bebc65379?recursive=1")
        .headers(headers.clone())
        .send()?
        .json::<GithubResponse>()?
        .tree;

    let latest_version: Vec<&GitHubFile> = git_tree
        .iter()
        .filter(|f| f.path.starts_with("src/") && f.path.ends_with(".md"))
        .collect();

    let pb = ProgressBar::new(latest_version.iter().len() as u64);

    for f in latest_version.iter() {
        let title = f.path.split_once('/').unwrap().1;
        let rawfile_link = f.to_rawfile_link();
        let markdown = client
            .get(rawfile_link)
            .headers(headers.clone())
            .send()?
            .text()?;

        fs::create_dir_all(book_dir())?;
        let path = book_dir();
        let path = path.join(title);

        let mut file = File::create(path)?;
        file.write_all(markdown.as_bytes())?;

        pb.inc(1);
    }

    pb.finish();

    let mut stdout = io::stdout();
    execute!(stdout, terminal::Clear(terminal::ClearType::All)).unwrap();

    return get_markdown_pages();
}
