" Indentation

" Automatically continue indentation across lines 
set autoindent
" Keep indentation structure (tabs, spaces, etc) when autoindenting.
set copyindent
" Automatically indent new lines after specific keywords or braces
set smartindent
" Indent if the line starts with these words
set cinwords+=def,class,except,try
" Don't jump to the start of a line when typing #
inoremap # X<c-h>#

" Tab stuff
" Size of a \t
set tabstop=4
" Delete this many space chars when pressing backspace
set softtabstop=4
set shiftwidth=4

" set [no]expandtab to [not] use spaces
"function SetTabs(n)
"	exec "set tabstop=" . a:n
"	exec "set softtabstop=" . a:n
"	exec "set shiftwidth=" . a:n
"endfunction

" Use :retab to change the file to entirely space indents
" Use :retab! to change the file to entirely tab indents

