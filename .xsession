#!/gnu/usr/bin/bash

cd

if [ "$(uname)" = "SunOS" ]; then
	# Congo ninja power!
	touch ~/.RSHTOCONGO
	rsh "$(/local/mc/bin/pick)" "DISPLAY=$DISPLAY /usr/bin/env bash --login ~/.xsession"
	if [ -e ~/.RSHTOCONGO ]; then
		# If we failed to get to a congo, then fallback to an xterm
		xterm
		rm -f ~/.RSHTOCONGO
	fi
	exit
fi

xscreensaver &
~suits/pub/win32/mapaltxwin32 -s

# We're on a congo!
rm -f ~/.RSHTOCONGO

# Merge resources
if [ -r ~/.Xresources ]; then
	xrdb -merge ~/.Xresources
fi

# Set the locale
export LC_CTYPE=en_AU.UTF-8

# If there's no XRENDER disable transparency
xdpyinfo | grep -q "RENDER"
if [ \! $? -eq 0 ]; then
	xrdb -merge <(echo URxvt.inheritPixmap: False)
fi

# Set a desktop background (use the -a option after -e to scale to 
# the max preserving aspect ratio)
# It would be better to put these in ~/GNUStep/Library/WindowMaker/autostart
# which gets run _after_ WindowMaker
# wmsetbg -b black -S -e -d -u /usr/share/backgrounds/images/default.png
# ~suits/pub/bin/randombg2 --permanent --quiet /usr/share/backgrounds/images

# If an exec fails, try the next one
shopt -s execfail
exec ~suits/pub/bin/wmaker --no-dock || exec icewm || exec rxvt || exec xterm

