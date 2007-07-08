" Python Calculator
command! -nargs=+ Calc :r! python -c "from math import *; print <args>"

" Unhighlight search results
map <C-l> :nohlsearch<CR>:redraw!<CR>

" Map Y to be consistent with D, C, etc
noremap Y y$

" CTRL-n and CTRL-p to go forwards and backwards through files
nnoremap <C-n> :next<CR>
nnoremap <C-p> :prev<CR>


