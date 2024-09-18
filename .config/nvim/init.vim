" setting leader key to space
let mapleader= "\<Space>"
let maplocalleader= "\<Space>"

set runtimepath^=~/.vim runtimepath+=/.vim/after
let &packpath = &runtimepath


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Hit '%' on 'if' to jump to 'else'
runtime macros/matchit.vim

" libraries
packadd! plenary.nvim

packadd! goyo.vim
packadd! tabular
packadd! vim-fugitive
packadd! vim-gutentags
packadd! vim-signify
packadd! nvim-web-devicons

" syntax highlighting for new languages
packadd! yuck.vim

" Lualine
packadd! lualine.nvim
lua require('plugins/lualine')

" telescope
packadd! telescope.nvim
packadd! telescope-fzf-native.nvim
lua require('plugins/telescope')

" tree-sitter
packadd! nvim-treesitter
packadd! playground
lua require('plugins/treesitter')

" NOTE(Aurel): This one cmp source is needed in the lsp config as well and needs
" to be loaded beforehand!
packadd! cmp-nvim-lsp

" LSP
packadd! nvim-lspconfig
packadd! null-ls.nvim
packadd! lspkind-nvim
packadd! clangd_extensions.nvim
lua require('lsp/config')

" jdtls (java)
packadd! nvim-jdtls
augroup jdtls_lsp
	autocmd!
	autocmd FileType java lua require('lsp/servers/jdtls').setup()
augroup end

" snippy
packadd! nvim-snippy
lua require('plugins/snippy')

" cmp
packadd! cmp-omni
packadd! cmp-snippy
packadd! cmp-buffer
packadd! cmp-path
packadd! nvim-cmp
lua require('plugins/cmp')

" VimTeX
let g:tex_flavor = "latex" " set default tex flavour to latex
let g:vimtex_compiler_progname = 'nvr'

let g:vimtex_compiler_latexmk = {
	\ 'out_dir' : 'build',
	\ 'callback' : 1,
	\ 'continuous' : 1,
	\ 'executable' : 'latexmk',
	\ 'hooks' : [],
	\ 'options' : [
	\   '-verbose',
	\   '-file-line-error',
	\   '-synctex=1',
	\   '-interaction=nonstopmode',
	\   '-shell-escape',
	\   '-enable-write18',
	\ ],
	\}
let g:vimtex_context_pdf_viewer='zathura'
packadd! vimtex

" typst
let g:typst_embedded_languages = ["c", "bash", "sh", "rust"]
let g:typst_pdf_viewer = "zathura"
packadd! typst.vim

" Goyo
function! s:goyo_enter()
	let b:quitting = 0
	let b:quitting_bang = 0
	autocmd QuitPre <buffer> let b:quitting = 1
	cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
	" Quit vim if this is the only remaining buffer
	if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
		if b:quitting_bang
			qa!
		else
			qa
		endif
	endif
endfunction

augroup goyo_config
	autocmd!
	autocmd User GoyoEnter call <SID>goyo_enter()
	autocmd User GoyoLeave call <SID>goyo_leave()
augroup END

let g:goyo_width=85

" Signify
" faster updatetime, as default is too slow
set updatetime=100


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" backspace over indentation, line breaks and start of insert
set backspace=indent,eol,start

" don't unload not shown buffers
set hidden
" autoread the file, when it's changed from the outside
set autoread
" confirm write and saveas
set confirm

" caches
if !isdirectory($XDG_CACHE_HOME . "/nvim/undo")
  call mkdir($XDG_CACHE_HOME . "/nvim/undo", "p")
endif
set undofile
set undodir=$XDG_CACHE_HOME/nvim/undo//

if !isdirectory($XDG_CACHE_HOME . "/nvim/backup")
  call mkdir($XDG_CACHE_HOME . "/nvim/backup", "p")
endif
set backup
set backupdir=$XDG_CACHE_HOME/nvim/backup//
" don't back up these directories
set backupskip^=/dev/shm/*
set backupskip^=/var/tmp/*

set viminfo+=n$XDG_CACHE_HOME/nvim/viminfo
set noswapfile
set history=500

filetype plugin indent on

" indentation
set autoindent
set noexpandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
silent! set breakindent

" splits should open on the right and below
set splitbelow
set splitright

" soft wrapping text
set wrap linebreak nolist
set textwidth=80

" spell checking by default
set spell
set spelllang=de_de,en_us

" visuals
set number
set signcolumn=yes
set foldcolumn=0
set colorcolumn=81
set cmdheight=1
set scrolloff=40
set ruler
" turning on wildmenu for command completion
set wildmenu
set completeopt-=preview
" ignore some files
set wildignore=*.o,*~,*.pyc,*.d
if has("win16") || has("win32")
	set wildignore+=.git\*,.hg\*,.svn\*
else
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
" set the cursor to not blink
set guicursor+=n-v-c:blinkon0
" don't show line numbers in terminal
au TermOpen * set nonumber norelativenumber signcolumn=no

" searching
set incsearch  " incremental search
set ignorecase " ignore case when searching
set smartcase  " try to be smart about cases when searching
set nohlsearch " highlight search results
" remove highlighting using <leader> h
nnoremap <silent> <leader>h :nohlsearch<CR>
" search for .nvimrc in the current pwd - project specific virc
set exrc
set secure

" no annoying error bells on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500

" disable mouse
set mouse=

" return to last edit position when opening files
if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$")
				\| exe "normal! g'\"" | endif
endif

" use unix as standard filetype and UTF-8
set fileformats=unix,dos,mac
set encoding=utf8

" close vim if quickfix window is the only window and tab
augroup QFClose
	autocmd!
	autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fast saving
nnoremap <silent> <leader>w :wa!<CR>

" trim whitespace
nnoremap <silent> <Leader>x :<C-U>call StripTrailingWhitespace()<CR>

" quickly copy to system clipboard
nnoremap <C-c> "+yy
vnoremap <C-c> "+y

nnoremap <silent> <leader>e :Ex<CR>

" faster moving between splits
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" vertical splitting with same file
nnoremap <silent> <leader>v :vsplit<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS / FONTS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable syntax highlighting
syntax on

if has('termguicolors')
	set termguicolors
endif
packadd! gruvbox-material
set background=dark
let g:gruvbox_material_italic=1
let g:gruvbox_material_background="hard"
let g:gruvbox_material_palette="original"

let g:gruvbox_material_better_performance=1

" highlight functions blue
" see `:help gruvbox-material-faq`
function! s:gruvbox_material_custom() abort
	highlight! link TSFunction Blue
endfunction
augroup GruvboxMaterialCustom
	autocmd!
	autocmd ColorScheme gruvbox-material call s:gruvbox_material_custom()
augroup END

silent! colorscheme gruvbox-material

" don't conceal anything. Stop *bold* turning into bold in markdown files
set conceallevel=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   FILETYPES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup filetypes
	autocmd!
	autocmd BufNewFile,BufRead *.lds set filetype=asm " lds files are assembler
	autocmd BufNewFile,BufRead *.rasi set filetype=css " rasi files are css
augroup END
