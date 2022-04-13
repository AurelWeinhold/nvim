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

" add functionality to extract vimball files
packadd! vimball


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
"
if !isdirectory($XDG_CACHE_HOME . "/nvim/backup")
  call mkdir($XDG_CACHE_HOME . "/nvim/backup", "p")
endif
set backup
set backupdir=$XDG_CACHE_HOME/nvim/backup//
" don't back up these directories
set backupskip^=/dev/shm/*
set backupskip^=/var/tmp/*
"
set viminfo+=n$XDG_CACHE_HOME/nvim/viminfo
set noswapfile
set history=500

filetype plugin indent on

" indentation
set autoindent
set expandtab
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

" return to last edit position when opening files
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$")
                \| exe "normal! g'\"" | endif
endif

" use unix as standard filetype
set fileformats=unix,dos,mac

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

" map <Ctrl>c to copy to and <Ctrl>v to paste from system clipboard
nnoremap <C-c> "+yy
vnoremap <C-c> "+y

nnoremap <silent> <leader>e :Ex<CR>

" faster moving between splits
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS / FONTS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable syntax highlighting
syntax on

packadd! gruvbox-material
set termguicolors
set background=dark
let g:gruvbox_material_italic=1
let g:gruvbox_material_sign_column_background="bg0"
let g:gruvbox_material_color_column_background="bg0"
let g:gruvbox_material_background="hard"
let g:gruvbox_material_palette="original"
silent! colorscheme gruvbox-material

" don't conceal anthing. Stop *bold* turning into bold in markdown files
set conceallevel=0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   FILETYPES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup filetypes
    autocmd!
    autocmd BufNewFile,BufRead *.lds set filetype=asm " lds files are assembler
    autocmd BufNewFile,BufRead *.rasi set filetype=css " rasi files are css
augroup END