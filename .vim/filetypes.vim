" Make vim aware of filetypes, this loads files in
" vimdir/{ftplugin,indent}/lang.vim 
" where vimdir is /usr/share/vim/vimXX/ or ~/.vim/
" The intention is for vim to set up sensible indentation rules and other
" settings depending on the filetype. 
filetype plugin indent on

" Pick up some filetypes from their extensions
autocmd BufNewFile,BufRead *.txt setlocal ft=text
autocmd BufNewFile,BufRead mutt* setlocal ft=mail
autocmd BufNewFile,BufRead *.tex setlocal ft=tex

" Set options based on filetypes, overriding the filetype plugin/indent options
autocmd FileType text setlocal wrap
autocmd FileType bib setlocal textwidth=78 nocindent smartindent
autocmd FileType mail setlocal textwidth=78
autocmd FileType tex setlocal wrap showbreak=>\ \ \ \ \ \ \  
autocmd FileType objc setlocal textwidth=78 nocindent smartindent

" Don't automatically continue comments on new lines
"""autocmd BufNewFile,BufRead * setlocal formatoptions-=r

