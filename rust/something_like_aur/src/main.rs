use std::rc::Rc;

use clap::Parser;
use tui_view::{create_view, event, App, Opts, Page};

use crate::aur::Aur;

mod aur;

fn main() {
    let aur_connection = aur::Aur::parse();

    struct ViewOpts {
        pages: Vec<Page>,
        aur_connection: Aur,
    }

    impl Opts for ViewOpts {
        fn get_pages(&self) -> Vec<Page> {
            self.pages.clone()
        }

        fn keybinds(&self, key: event::KeyEvent, mut app: App) -> App {
            if key.modifiers == event::KeyModifiers::NONE && key.code == event::KeyCode::Enter {
                let search = app.search.iter().collect();
                let result = self.aur_connection.search(search);
                match result {
                    Ok(packages) => {
                        let pages = packages
                            .iter()
                            .map(|package| {
                                Page::new(
                                    package.clone().to_string(),
                                    package.clone().name.unwrap(),
                                    package.clone().popularity,
                                )
                            })
                            .collect::<Vec<Page>>();

                        app.search = vec![];
                        app.pages = pages.clone();
                        app.current_pages = pages;
                    }
                    Err(err) => {
                        app.show_popup = true;
                        app.popup_content = err.to_string();
                    }
                };
            }

            if key.modifiers == event::KeyModifiers::CONTROL
                && key.code == event::KeyCode::Char('q')
            {
                if let Some(index) = app.state.selected() {
                    if let Some(selected) = app.current_pages.get(index) {
                        let aur_response = self.aur_connection.info(selected.title.clone());
                        match aur_response {
                            Ok(package_info) => {
                                if let Some(page) = app.current_pages.get_mut(index) {
                                    page.contents = package_info.to_string();
                                }
                            }
                            Err(err) => {
                                app.show_popup = true;
                                app.popup_content = err.to_string();
                            }
                        }
                    } else {
                        app.show_popup = true;
                        app.popup_content = "No package is selected!".to_string();
                    }
                }
            }

            if key.modifiers == event::KeyModifiers::CONTROL
                && key.code == event::KeyCode::Char('s')
            {
                if let Some(index) = app.state.selected() {
                    if let Some(selected) = app.current_pages.get(index) {
                        let aur_response = self.aur_connection.info(selected.title.clone());
                        match aur_response {
                            Ok(package_info) => {
                                let install_result = self.aur_connection.install(&package_info);

                                match install_result {
                                    Ok(_) => {
                                        app.show_popup = true;
                                        app.popup_content = format!(
                                            "{} has been installed successfully",
                                            package_info.name.unwrap_or_default()
                                        );
                                    }
                                    Err(err) => {
                                        app.show_popup = true;
                                        app.popup_content = err.to_string();
                                    }
                                }
                            }
                            Err(err) => {
                                app.show_popup = true;
                                app.popup_content = err.to_string();
                            }
                        }
                    }
                }
            }

            app
        }
    }

    let opts = Rc::new(ViewOpts {
        pages: vec![],
        aur_connection,
    });

    let _ = create_view(opts);
}
