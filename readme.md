My Neovim configuration
===

This is my personalized neovim configuration.

## Requirements
- git
- ctags
- [fzf](https://github.com/junegunn/fzf.git)
- [tree-sitter](https://github.com/tree-sitter/tree-sitter.git) + grammars
- lsp-servers:
    - [clangd](https://github.com/clangd/clangd) for C and C++
    - [vimls](https://github.com/iamcco/vim-language-server) for VimL
    - [texlab](https://github.com/latex-lsp/texlab) for LaTeX
    - [bashls](https://github.com/bash-lsp/bash-language-server) for bash
    - [cmake](https://github.com/regen100/cmake-language-server) for CMakeList
      files
    - [tsserver](https://github.com/Microsoft/TypeScript/wiki/Standalone-Server-%28tsserver%29)
      for typescript
- nodejs and npm as some of the servers are written in nodejs
- python and pip for some of the servers

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
- [Vimball](https://www.vim.org/scripts/script.php?script_id=1502) (built-in) to
  create, extract and list the contents of vimball archives
- [snap](https://github.com/camspiers/snap.git) a fast finder system, I use for
  file navigation.
- [tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter.git) for
  tree-sitter support
- [lspconfig](https://github.com/neovim/nvim-lspconfig.git) for simple
  configuration of the built-in LSP client
- [lspkind](https://github.com/onsails/lspkind-nvim) to add pictograms of the
  type of completion item.
- [lspstatus](https://github.com/nvim-lua/lsp-status.nvim.git) to generate
  statusline components using the built-in LSP client.

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

I'm also trying out the texlab language server (see LSP).

### Tree-sitter
[Tree-sitter](https://github.com/tree-sitter/tree-sitter.git) is a parser
generator tool and an incremental parsing library. It allows you to do anything
you want with the generated parsing tree, such as enhanced syntax highlighting
but also refactoring into a function. Go check it out, it's awesome!

### LSP
The [Language Server Protocol (LSP)](https://microsoft.github.io/language-server-protocol/)
is used for communication between editors and language servers, which may
provide a lot of functionality like auto complete items, go to definition, find
all references and more. It's awesome and brings IDE-like code-editing to any
texteditor supporting the protocol, as Neovim does. Go check it out!

## Mappings
- `<leader>` is the space key
- small plugin to strip trailing whitespace on `<leader>x`
- quicker saving on `<leader>w`
- yanking to the system clipboard using `<C-c>` in normal and visual mode
- quickly move between splits by replacing the `<C-W>` with just `<Ctl>`
