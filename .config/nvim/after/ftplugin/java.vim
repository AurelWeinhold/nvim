setlocal cmdheight=2

" substitute . for / in include statements
setlocal includeexpr=substitute(v:fname,'\\.','/','g')

setlocal path+=src
setlocal path+=src/main/java

" set the compiler to maven per default
compiler maven

" build
nnoremap <buffer> <leader>m :make!<CR>
nnoremap <buffer> <leader>n :cnext<CR>
