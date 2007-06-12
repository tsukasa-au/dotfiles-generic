" Pretty syntax highlighting
syntax on

" Show the line/column positions at the bottom
set ruler

" Display as much as possible of the last line of text
" (instead of displaying an @ character)
set display+=lastline

" Wrapping is annoying
set nowrap

" If wordwrap is on, don't split words across lines
set linebreak

" Don't wrap my lines at 78 chars please!
set textwidth=0

" String to put at the start of lines that have been wrapped
"set showbreak=+
set showbreak=

" Display current mode and partially typed commands
set showmode
set showcmd

" When a bracket is inserted, briefly jump to the matching one (
set showmatch

" Show the filename title in xterms
set title

" Make the autocompletion of filenames,etc behave like bash
set wildmode=longest,list

