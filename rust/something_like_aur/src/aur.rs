use std::{fmt, fs::File, io::Cursor, process::Command};

use clap::Parser;
use serde::Deserialize;
use tui_view::Result;

#[derive(Parser, Clone)]
pub struct Aur {
    #[arg(long, default_value = "https://aur.archlinux.org")]
    pub url_base: String,
    #[arg(long, default_value = "/rpc/?v=5&type=info")]
    url_postfix_info: String,
    #[arg(long, default_value = "/rpc/?v=5&type=search")]
    url_postfix_search: String,
}

#[derive(Deserialize, Debug)]
#[serde(tag = "type")]
enum AurResult {
    #[serde(rename = "search")]
    Search {
        #[serde(rename = "results")]
        packages: Vec<Package>,
    },
    #[serde(rename = "multiinfo")]
    Info {
        #[serde(rename = "results")]
        packages: Vec<Package>,
    },
    #[serde(rename = "error")]
    Error { error: String },
}

#[derive(Deserialize, Clone, Debug)]
#[serde(rename_all = "PascalCase")]
pub struct Package {
    pub description: Option<String>,
    pub id: Option<u64>,
    pub maintainer: Option<String>,
    pub name: Option<String>,
    pub num_votes: Option<u64>,
    pub package_base: Option<String>,
    pub package_base_id: Option<u64>,
    pub popularity: Option<f64>,
    #[serde(rename = "URL")]
    pub url: Option<String>,
    #[serde(rename = "URLPath")]
    pub url_path: Option<String>,
    pub depends: Option<Vec<String>>,
    pub make_depends: Option<Vec<String>>,
    pub opt_depends: Option<Vec<String>>,
    pub check_depends: Option<Vec<String>>,
    pub conflicts: Option<Vec<String>>,
    pub provides: Option<Vec<String>>,
    pub replaces: Option<Vec<String>>,
    pub groups: Option<Vec<String>>,
    pub license: Option<Vec<String>>,
    pub keywords: Option<Vec<String>>,
}

impl Aur {
    pub fn search(&self, package: String) -> Result<Vec<Package>> {
        let mut url = self.url_base.clone();
        url.push_str(&self.url_postfix_search);
        url.push_str(format!("&arg={}", package).as_str());

        let results = reqwest::blocking::get(url)?.json::<AurResult>()?;

        match results {
            AurResult::Error { error } => Err(Box::<dyn std::error::Error>::from(error)),
            AurResult::Search {
                packages: mut results,
            } => {
                results.sort_by(|a, b| b.popularity.partial_cmp(&a.popularity).unwrap());
                Ok(results)
            }
            AurResult::Info { packages: _ } => {
                Err(Box::<dyn std::error::Error>::from("Search returned info"))
            }
        }
    }
    pub fn info(&self, package: String) -> Result<Package> {
        let mut url = self.url_base.clone();
        url.push_str(&self.url_postfix_info);
        url.push_str(format!("&arg[]={}", package).as_str());

        let results = reqwest::blocking::get(url)?.json::<AurResult>()?;

        match results {
            AurResult::Error { error } => Err(Box::<dyn std::error::Error>::from(error)),
            AurResult::Info {
                packages: mut results,
            } => Ok(results.remove(0)),
            AurResult::Search { packages: _ } => {
                Err(Box::<dyn std::error::Error>::from("Info returned search"))
            }
        }
    }
    pub fn install(&self, package: &Package) -> Result<()> {
        let mut pkgbuild_url = self.url_base.clone();
        pkgbuild_url.push_str(package.url_path.clone().unwrap().as_str());

        let response = reqwest::blocking::get(pkgbuild_url)?;

        let xdg_dirs = xdg::BaseDirectories::with_prefix("sola").unwrap();

        let mut file_name = package.name.clone().unwrap();
        file_name.push_str(".tar.gz");

        let cache_file_path = xdg_dirs.place_cache_file(file_name.clone())?;
        let mut cache_file = File::create(cache_file_path.clone())?;

        let mut content = Cursor::new(response.bytes()?);
        std::io::copy(&mut content, &mut cache_file)?;

        let _ = Command::new("bash")
            .args([
                "-c",
                "cd",
                &xdg_dirs.get_cache_home().display().to_string(),
                "&&",
                "tar",
                "-xvf",
                &file_name,
                "&&",
                "cd",
                cache_file_path.into_os_string().to_str().unwrap(),
                "&&",
                "makepkg",
                "-si",
            ])
            .output()?;

        Ok(())
    }
}

impl fmt::Display for Package {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let package = self.clone();

        write!(f, " Description: {}\n Id: {}\n Maintainer: {}\n Name: {}\n Votes: {}\n Package Base: {}\n Package Base Id: {}\n Popularity: {}\n Url: {}\n Url Path: {}\n Depends: {}\n Make Depends: {}\n Opt Depends: {}\n Check Depends: {}\n Conflicts: {}\n Provides: {}\n Replaces: {}\n Groups: {}\n License: {}\n Keywords: {}\n", package.description.unwrap_or_default(), package.id.unwrap_or_default(), package.maintainer.unwrap_or_default(), package.name.unwrap_or_default(), package.num_votes.unwrap_or_default(), package.package_base.unwrap_or_default(), package.package_base_id.unwrap_or_default(), package.popularity.unwrap_or_default(), package.url.unwrap_or_default(), package.url_path.unwrap_or_default(), package.depends.unwrap_or_default().join(", "), package.make_depends.unwrap_or_default().join(", "), package.opt_depends.unwrap_or_default().join(", "), package.check_depends.unwrap_or_default().join(", "), package.conflicts.unwrap_or_default().join(", "), package.provides.unwrap_or_default().join(", "), package.replaces.unwrap_or_default().join(", "), package.groups.unwrap_or_default().join(", "), package.license.unwrap_or_default().join(", "), package.keywords.unwrap_or_default().join(", "))
    }
}
