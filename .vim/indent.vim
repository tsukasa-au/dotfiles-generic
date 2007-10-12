" Indentation

" Automatically continue indentation across lines 
set autoindent
" Keep indentation structure (tabs, spaces, etc) when autoindenting.
set copyindent
" Automatically indent new lines after specific keywords or braces
set smartindent
" Don't jump to the start of a line when typing #
inoremap # X<c-h>#

" Tab stuff
" Size of a \t
set tabstop=4
" Delete this many space chars when pressing backspace
set softtabstop=4
set shiftwidth=4

" Use :retab to change the file to entirely space indents
" Use :retab! to change the file to entirely tab indents

