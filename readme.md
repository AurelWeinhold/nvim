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
- [Devicons](https://github.com/ryanoasis/vim-devicons) to add good looking
  icons
- [Fugitive](https://github.com/tpope/vim-fugitive.git), a Git wrapper
- [Goyo](https://github.com/junegunn/goyo.vim) for distraction-less writing
- [Gruvbox-Material](https://github.com/sainnhe/gruvbox-material)
- [Gutentags](https://github.com/ludovicchabant/vim-gutentags.git) for improved
  tags support, like automatically incrementally (re)generating appropriate tag
  files.
- [Lualine](https://github.com/nvim-lualine/lualine.nvim.git) as my statusline
- [Signify](https://github.com/mhinz/vim-signify.git) adds vcs signs to
  signcoloumn
- [Tabular](https://github.com/godlygeek/tabular.git) to align text like
  markdown tables
- [VimTeX](https://github.com/lervag/vimtex.git) for the best LaTeX experience
  there is. See below how I set up my LaTeX workflow.

## Noteworthy
### LaTeX
LaTeX writing can be cumbersome. This is my attempt to make it a lot better!

#### VimTeX
VimTeX is the best plugin to write LaTeX in Vim that I have found to this day.
It is highly configurable but adds very sane defaults, which I also mostly use
(see `:help vimtex-default-mappings`).

I use it for the very good syntax highlighting it brings, for compiling my
document asynchronously using
[latexmk](https://personal.psu.edu/~jcc8/software/latexmk/), to open that
compiled document in my preferred pdf-viewer
[Zathura](https://pwmt.org/projects/zathura/), also enabling forward search, and
for its provided text objects to navigate the LaTeX structure better. Go check
it out!

## Mappings
- `<leader>` is the space key
- small plugin to strip trailing whitespace on `<leader>x`
- quicker saving on `<leader>w`
- yanking to the system clipboard using `<C-c>` in normal and visual mode
- quickly move between splits by replacing the `<C-W>` with just `<Ctl>`
