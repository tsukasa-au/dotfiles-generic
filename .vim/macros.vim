" Python Calculator
command! -nargs=+ Calc :r! python -c "from math import *; print <args>"

" I frequently type :Q or :WQ, etc instead of :q, :wq
command! WQA :wqa
command! WqA :wqa
command! WQa :wqa
command! Wqa :wqa
command! WA :wa
command! Wa :wa
command! WQ :wq
command! Wq :wq
command! W :w
command! Wn :wn
command! WN :wn
command! Wp :wp
command! WP :wp
command! QA :qa
command! Qa :qa
command! Q :q

" Unhighlight search results
nmap <C-l> :nohlsearch<CR>:redraw!<CR>

" Map Y to be consistent with D, C, etc
nmap Y y$

" CTRL-n and CTRL-p to go forwards and backwards through files
nmap <C-n> :next<CR>
nmap <C-p> :prev<CR>

" CTRL-J/K to move up and down, collapsing open windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

" Press CTRL-z after pasting something to fix up formatting
imap <C-z> <ESC>u:set paste<CR>.:set nopaste<CR>i

" Tab to switch between split windows
nmap <Tab> <C-w><C-w>

" Q to reformat paragraph. I never use ex mode anyway (default binding for Q)
nmap Q gwip

" Go up and down by display lines, not linebreaks
imap <Down> <C-o>gj
imap <Up> <C-o>gk
nmap <Down> gj
nmap <Up> gk

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

