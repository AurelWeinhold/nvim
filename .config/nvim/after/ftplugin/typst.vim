nnoremap <silent> <leader>ll :TypstWatch<Cr>

" only enable if g:typst_cmd is set which indicates that typst.vim is installed
if exists("g:typst_cmd")
	" open toc in horizontal mode
	nnoremap <silent> gO :Toc<Cr>
endif
