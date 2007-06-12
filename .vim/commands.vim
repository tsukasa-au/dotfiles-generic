" Python Calculator
command! -nargs=+ Calc :r! python -c "from math import *; print <args>"

" Unhighlight search results
map <C-l> :nohlsearch<CR>:redraw!<CR>

" Commenting of lines! Stolen & modified from vim.org's ToggleCommentify
map <C-c> :call ToggleCommentify()<CR>j
imap <C-c> <ESC>:call ToggleCommentify()<CR>j
" The nice thing about these mapping is that you don't have to select a visual block to comment 
" ... just keep the CTRL-key pressed down and tap on 'c' as often as you need. 

function! ToggleCommentify()
	let lineString = getline(".")
	if lineString != $									" don't comment empty lines
		let isCommented = strpart(lineString,0,3)		" getting the first 3 symbols
		let fileType = &ft								" finding out the file-type, and specifying the comment symbol
		if fileType == 'ox' || fileType == 'java' || fileType == 'cpp' || fileType == 'c' || fileType == 'php'
			let commentSymbol = '///'
		elseif fileType == 'vim'
			let commentSymbol = '"""'
		elseif fileType == 'python' || fileType == 'sh'
			let commentSymbol = '###'
		else
			execute 'echo "ToggleCommentify has not (yet) been implemented for this file-type"'
			let commentSymbol = ''
		endif
		if isCommented == commentSymbol					
			call UnCommentify(commentSymbol)			" if the line is already commented, uncomment
		else
			call Commentify(commentSymbol)				" if the line is uncommented, comment
		endif
	endif
endfunction

function! Commentify(commentSymbol)	
	execute ':s+^+'.a:commentSymbol.'+'
	nohlsearch
endfunction
	
function! UnCommentify(commentSymbol)	
	execute ':s+'.a:commentSymbol.'++'
	nohlsearch
endfunction

