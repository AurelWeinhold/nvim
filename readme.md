My Neovim configuration
===

This is my personalized neovim configuration.


## Dependencies
- [ctags](https://github.com/universal-ctags/ctags)
- [fzf](https://github.com/junegunn/fzf.git)
- [git](https://git-scm.com/)
- LSP-servers:
    - [bashls](https://github.com/bash-lsp/bash-language-server) for bash
    - [clangd](https://github.com/clangd/clangd) for C and C++
    - [cmake](https://github.com/regen100/cmake-language-server) for CMakeList
      files
    - [jdtls](https://github.com/eclipse/eclipse.jdt.ls.git) for java
    - [texlab](https://github.com/latex-lsp/texlab) for LaTeX
    - [tsserver](https://github.com/Microsoft/TypeScript/wiki/Standalone-Server-%28tsserver%29)
      for typescript
    - [vimls](https://github.com/iamcco/vim-language-server) for VimL
- [Neovim](https://neovim.io/) (>0.5)
- [tree-sitter](https://github.com/tree-sitter/tree-sitter.git) + grammars


## Installation
NOTE: I have not tested these steps yet as I already have everything installed.
This should work though, I'm pretty sure. I will remove this note once I had the
chance to actually test.

1. Clone this repo
2. Pull the submodules by running
   ```
   git submodule update --init --recursive
   ```
   this will install all plugins but not the dependencies.
3. In `.local/share/nvim/site/pack/functionality/opt/telescope-fzf-native.nvim/`
   compile `telescope-fzf-native.nvim` by running
   ```
   cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release
   cmake --build build --config Release
   cmake --install build --prefix build
   ```
4. symlink or copy the files to their appropriate locations. All the files are
   located relative to `$HOME`. The directory `.config/nvim` thus needs to go to
   `$HOME/.config/nvim`.

   You can do this manually or use [stow](https://www.gnu.org/software/stow/)
   using
   ```
   stow --target=$HOME nvim
   ```
   from the directory in which you cloned this repo.
5. Everything should be installed and at the right place now, so open Neovim and
   run
   ```
   :helptags ALL
   :mkspell ~/.config/nvim/spell/*.add
   ```
   to generate the helptags (`:help :helptags`) and compile the spell
   file(`:help :mkspell`). This will enable you to look through the help pages
   of the plugins make spell suggestions faster.

Before using neovim make sure you have set the environmental variable
`$XDG_CACHE_HOME`.

## Colors
- [Gruvbox-Material](https://github.com/sainnhe/gruvbox-material)

Using the original dark color scheme with a hard contrast.

I've also set the sign and color column to be the background color, to have a
unified layout in my buffers.


## Plugins
- [cmp](https://github.com/hrsh7th/nvim-cmp.git)
- completion sources
    - [lsp](https://github.com/hrsh7th/cmp-nvim-lsp.git)
    - [snippy](https://github.com/dcampos/cmp-snippy.git)
    - [words in buffer](https://github.com/hrsh7th/cmp-buffer.git)
    - [path](https://github.com/hrsh7th/cmp-path.git)
- [Devicons](https://github.com/ryanoasis/vim-devicons) to add good looking
  icons
- [Fugitive](https://github.com/tpope/vim-fugitive.git), a Git wrapper
- [Goyo](https://github.com/junegunn/goyo.vim) for distraction-less writing
- [Gruvbox-Material](https://github.com/sainnhe/gruvbox-material)
- [Gutentags](https://github.com/ludovicchabant/vim-gutentags.git) for improved
  tags support, like automatically incrementally (re)generating appropriate tag
  files.
- LSP:
    - [lspconfig](https://github.com/neovim/nvim-lspconfig.git) for simple
      configuration of the built-in LSP client
    - [lspkind](https://github.com/onsails/lspkind-nvim) to add pictograms of
      the type of completion item.
    - [lspstatus](https://github.com/nvim-lua/lsp-status.nvim.git) to generate
      statusline components using the built-in LSP client.
    - [jdtls](https://github.com/mfussenegger/nvim-jdtls.git) for supporting
      jdtls for java which needs a little more than just the standard
      LSP-configuration.
- [Lualine](https://github.com/nvim-lualine/lualine.nvim.git) as my statusline
- [Signify](https://github.com/mhinz/vim-signify.git) adds vcs signs to
  signcoloumn
- [snap](https://github.com/camspiers/snap.git) a fast finder system, I use for
  file navigation.
- [snippy](https://github.com/dcampos/nvim-snippy.git) for snippets
- [Tabular](https://github.com/godlygeek/tabular.git) to align text like
  markdown tables
- [tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter.git) for
  tree-sitter support
- [Vimball](https://www.vim.org/scripts/script.php?script_id=1502) (built-in) to
  create, extract and list the contents of vimball archives
- [VimTeX](https://github.com/lervag/vimtex.git) for the best LaTeX experience
  there is. See below how I set up my LaTeX workflow.


## Mappings
- `<leader>` is mapped to the space key
- small plugin to strip trailing whitespace on `<leader>x`
- quicker saving on `<leader>w`
- yanking to the system clipboard using `<C-c>` in normal and visual mode
- quickly move between splits by replacing the `<C-W>` with just `<Ctl>`


## Noteworthy
### Tree-sitter
[Tree-sitter](https://github.com/tree-sitter/tree-sitter.git) is a parser
generator tool and an incremental parsing library. It allows you to do anything
you want with the generated parsing tree, such as enhanced syntax highlighting
but also refactoring into a function. Go check it out!

### LSP
The [Language Server Protocol (LSP)](https://microsoft.github.io/language-server-protocol/)
is used for communication between editors and language servers, which may
provide a lot of functionality like auto complete items, go to definition, find
all references and more. It's awesome and brings IDE-like code-editing to any
texteditor supporting the protocol, as Neovim does. Go check it out!

### Snippets
Snippets are small pieces of code that can be inserted using a key combination.
One might, for example, define a snippet
```latex
\begin{align*}
    #
\end{align*}
```
(where `#` is the cursor position after inserting the snippet) which gets
expanded using the key combination `align<Tab>`. This makes writing LaTeX and
other code much faster as you can shorten everything that you type often down to
a few keystrokes.

**I highly recommend writing your own snippets as to not lose track of the
snippets and to more easily remember what capabilities are implemented in your
setup, but feel free to get inspired by mine.**

### LaTeX
LaTeX writing can be cumbersome. This is my attempt to make it a lot better!

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

I'm also trying out the texlab language server (see LSP), which might at one
point replace vimtex.

I also use snippets to write my LaTeX code. As I have written my documents I
have incrementally added new snippets and updated existing ones the way I see
fits me best. This has drastically increased speed and decreased resistance
writing LaTeX documents! Feel free to check out my own snippets at
`.config/nvim/snippets/tex/*` to get inspired and guide you in how to write your
own snippets! Also, if you are using snippy, read the documentation (`:help
snippy`)


## TODO
- add LanguageTool support
	- possibly with yalafi integration to strip away latex
	- vimtex: vlty
- make java jdtls work again.
- test installation steps
- add update steps
- configure statusline
- unify jdtls and regular lsp config, or at least extract the mappings
- work on the jdtls setup - do we need to specify a workspace?
    - fix workspace as it's currently generated as
      `$HOME/Documents/workspace$PROJECTNAME` and not as directory under
      `workspace/`
- replace vimtex with LSP?
- add LSP mappings to readme
- check out `:h fo-table`
