" Don't try to be like vi
set nocompatible

" Backspace should work across lines
set bs=2

" Make vim aware of filetypes
filetype plugin on


" Read files from ~/.vim
source ~/.vim/backup.vim
source ~/.vim/state.vim
source ~/.vim/display.vim
source ~/.vim/mouse.vim
source ~/.vim/indent.vim
source ~/.vim/search.vim
source ~/.vim/commands.vim
source ~/.vim/commenter.vim
if !filereadable(expand("~/.vim/abbrsout.vim"))
	!python ~/.vim/abbrs2vim.py
endif
source ~/.vim/abbrsout.vim

