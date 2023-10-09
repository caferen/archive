[![Crate Status](https://img.shields.io/crates/v/tui_view.svg)](https://crates.io/crates/tui_view)
[![Docs Status](https://docs.rs/tui_view/badge.svg)](https://docs.rs/crate/tui_view/)

A reusable and mildly configurable TUI frontend library. 

The library aims to provide a simple way of loading some data into a terminal interface with no frontend programming. It provides basic actions but it is possible to define custom keybindings too.

All the user needs to do is implement the `Opts` trait with one mandatory method on a struct and pass it into the `create_view` function.

[Documentation](https://docs.rs/tui_view/latest/tui_view/)

Since typing searches, it is not possible to define custom keybindings without modifiers.

### Default keybindings
 - \<C-e\>: Exit
 - \<C-d\>: Scroll content down
 - \<C-u\>: Scroll content up
 - \<C-j\>: Select next dock item
 - \<C-k\>: Select previous dock item
 - \<C-b\>: Toggle dock
 - \<C-p\>: Toggle popup
 - Type to search.


