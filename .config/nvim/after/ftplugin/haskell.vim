setlocal cmdheight=2

let g:gutentags_enabled=0

autocmd BufWritePost *.hs :silent! exec "!hasktags -c -x -a -f tags src/ && LC_COLLATE=C sort tags -o tags"
