" a function to strip trailing whitespace
function StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
	normal mz
	normal Hmy
	%s/\s\+$//e
	normal 'yz<CR>
	normal `z
  endif
endfunction
