" Make vim aware of filetypes
filetype plugin indent on

" Pick up some filetypes from their extensions
autocmd BufNewFile,BufRead *.txt setlocal ft=text
autocmd BufNewFile,BufRead mutt* setlocal ft=mail
autocmd BufNewFile,BufRead *.tex setlocal ft=tex

" Set options based on filetypes
autocmd FileType text setlocal textwidth=78 nosmartindent
autocmd FileType mail setlocal textwidth=78 nosmartindent
autocmd FileType tex setlocal textwidth=78 nosmartindent

