This is a set of configuration files for a bunch of Unix apps I use regularly.

The way I usually use this is as follows. Change the lines as appropriate for
your system.

Install Git:
	$ sudo pacman -Syu git

Change into your home directory and make a clone of the repository:
	$ cd
	$ git clone https://github.com/tsukasa-au/dotfiles-generic.git .dotfiles

Make a backup of any existing files:
	$ mkdir backup
	$ mv .bash* .ssh .vim* .Xresources .xscreensaver .screenrc .pythonrc.py .inputrc .ssh backup

Symlink the config files into your home directory:
	$ for f in $(ls -A .dotfiles); do ln -s .dotfiles/$i .; done
	$ rm .hg .hgignore .git .gitignore


You're done now. You probably want to move your ssh keys back into ~/.ssh
(which now links to ~/.dotfiles/.ssh), as well as add a few machine specific
configs to the bash init scripts.

Create files in ~/.bash called environment_local, interactive_local, etc to
do this.

To simplify this, you can also just run:
  $ curl https://raw.githubusercontent.com/tsukasa-au/dotfiles-generic/master/git-setup.txt | bash
