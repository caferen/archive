use book::{MarkdownFile, Result};

use crate::book::read_the_book;
use crossterm::{
    cursor,
    event::{self, DisableMouseCapture, EnableMouseCapture, Event, KeyCode, KeyModifiers},
    execute,
    terminal::{
        self, disable_raw_mode, enable_raw_mode, EnterAlternateScreen, LeaveAlternateScreen,
    },
};

use std::{io, panic, time::Duration};
use tui::{
    backend::{Backend, CrosstermBackend},
    layout::{Constraint, Direction, Layout},
    style::{Modifier, Style},
    text::Text,
    widgets::{Block, Borders, Paragraph, Row, Table, TableState, Wrap},
    Frame, Terminal,
};
mod book;
struct App {
    state: TableState,
    items: Vec<MarkdownFile>,
    current_items: Vec<MarkdownFile>,
    scroll: u16,
    search: Vec<char>,
    latest_search: Vec<char>,
}

impl App {
    fn new() -> Result<Self> {
        let chapters = read_the_book()?;
        Ok(App {
            state: TableState::default(),
            items: chapters.clone(),
            scroll: 0,
            search: Vec::new(),
            current_items: chapters,
            latest_search: Vec::new(),
        })
    }

    pub fn next(&mut self) {
        let i = match self.state.selected() {
            Some(i) => {
                if i < self.current_items.len() - 1 {
                    i + 1
                } else {
                    i
                }
            }
            None => 0,
        };
        self.state.select(Some(i));
        self.scroll = 0;
    }

    pub fn previous(&mut self) {
        let i = match self.state.selected() {
            Some(i) => {
                if i == 0 {
                    0
                } else {
                    i - 1
                }
            }
            None => 0,
        };
        self.state.select(Some(i));
        self.scroll = 0;
    }

    pub fn load(&mut self) -> String {
        match self.state.selected() {
            Some(i) => match self.current_items.get(i) {
                Some(x) => x.contents.clone(),
                None => String::from(""),
            },
            None => String::from(""),
        }
    }

    pub fn scroll_down(&mut self) {
        self.scroll = self.scroll.checked_add(1).unwrap_or(self.scroll);
    }

    pub fn scroll_up(&mut self) {
        self.scroll = self.scroll.checked_sub(1).unwrap_or(self.scroll);
    }

    pub fn search(&mut self, search_phrase: String) {
        let search_phrase = search_phrase.trim().to_lowercase();

        if search_phrase.is_empty() {
            self.current_items = self.items.clone();
            return;
        }

        self.current_items = self
            .items
            .iter_mut()
            .map(|md_file| md_file.clone().search(&search_phrase))
            .filter(|md_file| md_file.relevancy > 0)
            .collect();

        self.current_items
            .sort_by(|a, b| b.relevancy.cmp(&a.relevancy));
    }
}

fn run_app<B: Backend>(terminal: &mut Terminal<B>, mut app: App) -> io::Result<()> {
    loop {
        terminal.draw(|f| ui(f, &mut app))?;

        if event::poll(Duration::from_millis(200))? {
            if let Event::Key(key) = event::read()? {
                match key.modifiers {
                    KeyModifiers::CONTROL => match key.code {
                        KeyCode::Char('e') => return Ok(()),
                        KeyCode::Char('d') => app.scroll_down(),
                        KeyCode::Char('u') => app.scroll_up(),
                        KeyCode::Char('j') => app.next(),
                        KeyCode::Char('k') => app.previous(),
                        _ => {}
                    },
                    _ => {
                        if key.code == KeyCode::Backspace {
                            app.search.pop();
                        }

                        if let KeyCode::Char(x) = key.code {
                            app.search.push(x);
                        }
                    }
                }
            }
        } else if app.search != app.latest_search {
            app.latest_search = app.search.clone();
            app.search(app.search.iter().collect());
            app.state.select(Some(0));
        }
    }
}

fn ui<B: Backend>(f: &mut Frame<B>, app: &mut App) {
    let main_layout = Layout::default()
        .direction(Direction::Horizontal)
        .constraints([Constraint::Percentage(30), Constraint::Percentage(70)])
        .split(f.size());

    let layout = Layout::default()
        .direction(Direction::Vertical)
        .constraints([Constraint::Min(5), Constraint::Percentage(90)])
        .split(main_layout[0]);

    let mut directory_rows = vec![];

    app.current_items.iter().for_each(|chapter| {
        let title = chapter.title.clone();
        directory_rows.push(Row::new(vec![title]))
    });

    let directory_title = if !app.search.is_empty() {
        "Directory (sorted by search relevancy)"
    } else {
        "Directory"
    };

    let directory_table = Table::new(directory_rows)
        .block(
            Block::default()
                .title(directory_title)
                .borders(Borders::ALL),
        )
        .widths(&[Constraint::Percentage(100)])
        .highlight_style(Style::default().add_modifier(Modifier::REVERSED));

    let page = Paragraph::new(app.load())
        .block(Block::default().title("Reader").borders(Borders::ALL))
        .scroll((app.scroll, 0))
        .wrap(Wrap { trim: false });

    let input_string: String = app.search.iter().collect();
    let lines = Text::from(input_string.as_str());
    let search = Paragraph::new(lines)
        .block(Block::default().title("Search").borders(Borders::ALL))
        .wrap(Wrap { trim: true });

    f.render_widget(search, layout[0]);
    f.render_widget(page, main_layout[1]);
    f.render_stateful_widget(directory_table, layout[1], &mut app.state);
}

fn cleanup_terminal() {
    let mut stdout = io::stdout();

    // Needed for when ytop is run in a TTY since TTYs don't actually have an alternate screen.
    // Must be executed before attempting to leave the alternate screen so that it only modifies the
    // 		primary screen if we are running in a TTY.
    // If not running in a TTY, then we just end up modifying the alternate screen which should have
    // 		no effect.
    execute!(stdout, cursor::MoveTo(0, 0)).unwrap();
    execute!(stdout, terminal::Clear(terminal::ClearType::All)).unwrap();

    execute!(stdout, terminal::LeaveAlternateScreen).unwrap();
    execute!(stdout, cursor::Show).unwrap();

    terminal::disable_raw_mode().unwrap();
}

fn setup_panic_hook() {
    panic::set_hook(Box::new(|panic_info| {
        cleanup_terminal();
        better_panic::Settings::auto().create_panic_handler()(panic_info);
    }));
}

// #[derive(Parser, Debug)]
// struct Args {
//     /// String to search in the book
//     needle: Option<String>,
//     // TODO: Factor out common code and make the app
//     // be able to open other books
//     // book: String,
// }

fn main() -> Result<()> {
    better_panic::install();

    // let args = Args::parse();

    // if args.needle.is_some() {
    //     let mut book = read_the_book()?;
    //     let needle = args.needle.unwrap().trim().to_lowercase();

    //     let mut relevant_pages = book
    //         .iter_mut()
    //         .map(|md_file| md_file.clone().search(&needle))
    //         .filter(|md_file| md_file.relevancy > 0)
    //         .collect::<Vec<MarkdownFile>>();

    //     relevant_pages.sort_by(|a, b| b.relevancy.cmp(&a.relevancy));
    //     let most_relevant_page = relevant_pages.first().unwrap();
    //     let most_relevant_paragraph = most_relevant_page.paragraphs.first().unwrap();

    //     println!("{}", most_relevant_page.contents.clone());
    // } else {
    enable_raw_mode()?;
    let mut stdout = io::stdout();

    execute!(stdout, EnterAlternateScreen, EnableMouseCapture)?;
    let backend = CrosstermBackend::new(stdout);

    let mut terminal = Terminal::new(backend)?;

    setup_panic_hook();

    let app = App::new()?;
    let res = run_app(&mut terminal, app);

    disable_raw_mode()?;
    execute!(
        terminal.backend_mut(),
        LeaveAlternateScreen,
        DisableMouseCapture
    )?;
    terminal.show_cursor()?;

    if let Err(err) = res {
        println!("{:?}", err)
    }
    // }

    Ok(())
}
