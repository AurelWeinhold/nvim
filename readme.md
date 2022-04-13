My Neovim configuration
===

This is my personalized neovim configuration.

## Requirements
- git
- ctags

## Colors
- [Gruvbox-Material](https://github.com/sainnhe/gruvbox-material)

Using the original dark color scheme with a hard contrast.

I've also set the sign and color column to be the background color, to have a
unified layout in my buffers.

## Plugins
- [Fugitive](https://github.com/tpope/vim-fugitive.git), a Git wrapper
- [Goyo](https://github.com/junegunn/goyo.vim) for distraction-less writing
- [Gruvbox-Material](https://github.com/sainnhe/gruvbox-material)
- [Gutentags](https://github.com/ludovicchabant/vim-gutentags.git) for improved
  tags support, like automatically incrementally (re)generating appropriate tag
  files.
- [Signify](https://github.com/mhinz/vim-signify.git) adds vcs signs to
  signcoloumn
- [Tabular](https://github.com/godlygeek/tabular.git) to align text like
  markdown tables

## Mappings
- `<leader>` is the space key
- small plugin to strip trailing whitespace on `<leader>x`
- quicker saving on `<leader>w`
- yanking to the system clipboard using `<C-c>` in normal and visual mode
- quickly move between splits by replacing the `<C-W>` with just `<Ctl>`
