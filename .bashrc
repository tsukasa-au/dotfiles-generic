# Run when a random bash is started. This is always run after the login
# shell. It sets up the shell to have a nice prompt and xterm titlebar, etc.
# It should NOT set any environment variables like the PATH.
# Copy this around to all your machines and make machine specific
# customisations to ~/.bashrc_local

# Run .bash_profile if logging in from ssh
[ ${RUN_BASH_PROFILE:-0} -eq 1 -a -f ~/.bash_profile ] && source ~/.bash_profile && return

# If not running interactively do nothing
[ -z "$PS1" ] && return

# Terminals that we want coloured prompts in
[ -n "$COLORTERM"           ] && PS1_COLOR=1
[ "$TERM" = "linux"         ] && PS1_COLOR=1 && DARK=1
[ "$TERM" = "screen"        ] && PS1_COLOR=1
[ "$TERM" = "xterm"         ] && PS1_COLOR=1
[ "$TERM" = "xterm-color"   ] && PS1_COLOR=1
[ "$TERM" = "rxvt"          ] && PS1_COLOR=1
[ "$TERM" = "rxvt-unicode"  ] && PS1_COLOR=1

# Use colours appropriate to a light on dark terminal, we can autodetect
# this for some terminals, for others we define it above.
if [ -n "$COLORFGBG" ]; then
	FGCOLOR=$(echo $COLORFGBG | cut -d ';' -f 1)
	BGCOLOR=$(echo $COLORFGBG | cut -d ';' -f 3)
	if [ "$FGCOLOR" -gt "$BGCOLOR" ]; then
		DARK=1
	fi
	unset FGCOLOR
	unset BGCOLOR
elif [ ${DARK:-0} -eq 0 ]; then
	export COLORFGBG="0;default;15"
elif [ ${DARK:-0} -eq 1 ]; then
	export COLORFGBG="15;default;0"
fi

# Set the prompt colour, and the colors for the 'ls' command appropriately,
# depending on the background of the terminal.
if [ ${PS1_COLOR:-0} -eq 1 ]; then
	if [ ${DARK:-0} -eq 0 ]; then
		LS_COLORS="no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35"
		PS1='\[\033[31m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[00m\]\$ '
	else
		LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
		PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	fi

	export LS_COLORS
	unset PS1_COLOR
	unset DARK
else
	PS1='\u@\h:\w\$ '
fi

function DARKTERM {
	unset COLORFGBG
	DARK=1 && source ~/.bashrc
}

# xterm titlebar displays current command
case "$TERM" in
xterm*|rxvt*)
	HOSTNAME="$(hostname | cut -d '.' -f 1)"
	CWD_WITHHOME='"$(echo "$PWD" | sed "s|^$HOME|~|")"'
	PROMPT_COMMAND="echo -ne \"\033]0;${HOSTNAME}: ${CWD_WITHHOME}\007\""
	;;
*)
	;;
esac

# Useful aliases
alias ls='ls --color=auto'
alias ll='ls -hlF'
alias la='ls -ha'
alias  l='ls -halF'
alias rm='rm -i'
alias less='less -R'
alias screen='TERM=screen screen'

shopt -s checkwinsize

# Local customisations
[ -r ~/.bashrc_local ] && source ~/.bashrc_local

