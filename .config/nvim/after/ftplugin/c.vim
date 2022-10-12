" include macros in completion
setlocal complete+=d

"set include pattern
setlocal include=^\\s*#\\s*include

" include headers
" ATTENTION only works on unix
"setlocal path+=/usr/include
setlocal path+=src,inc,include
" include tags files for these headers
"setlocal tags+=$HOME/.local/share/tags/c/std.tags
"setlocal tags+=$HOME/.local/share/tags/c/all.tags

" build
nnoremap <buffer> <leader>m :make!<CR>
nnoremap <buffer> <leader>n :cnext<CR>

" add functionality to debug using gdb in the terminal
packadd termdebug
