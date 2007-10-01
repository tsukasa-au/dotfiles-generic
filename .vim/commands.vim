" Python Calculator
command! -nargs=+ Calc :r! python -c "from math import *; print <args>"

" Unhighlight search results
map <C-l> :nohlsearch<CR>:redraw!<CR>

" Map Y to be consistent with D, C, etc
noremap Y y$

" CTRL-n and CTRL-p to go forwards and backwards through files
nnoremap <C-n> :next<CR>
nnoremap <C-p> :prev<CR>

" Press CTRL-X after pasting something to fix up formatting
imap <C-z> <ESC>u:set paste<CR>.:set nopaste<CR>i

" Spell checking mode toggle
function s:spell()
	if !exists("s:spell_check") || s:spell_check == 0
		echo  "Spell check on"
		let s:spell_check = 1
		setlocal spell spelllang=en_au
	else
		echo "Spell check off"
		let s:spell_check = 0
		setlocal spell spelllang=
	endif
endfunction
map <F8> :call <SID>spell()<CR>
imap <F8> <C-o>:call <SID>spell()<CR>

