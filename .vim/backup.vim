" Make a backup (i. e. 'file~') and save it.
set backup
" create ~/tmp/ if it doesn't exist and use ~/tmp to save the 
" backups into
if has("unix")
	if !isdirectory(expand("~/tmp/vimbak/."))
		!mkdir -p ~/tmp/vimbak
	endif
endif
set backupdir=~/tmp/vimbak
