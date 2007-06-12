# Run for login shells. That is, once when you log in via SSH this is run
# to set up your environment variables such as PATH, etc. It then calls
# .bashrc to set up aliases or prompts.
# Copy this around to all your machines and make machine specific
# customisations to ~/.bash_profile_local

unset RUN_BASH_PROFILE

# Source the global profile
[ -r /etc/profile ] && source /etc/profile

# rwx user only
umask 0077

# Environment variables that may be overidden in .bash_profile_local
export PAGER="less"
export EDITOR="vim"
export CVS_RSH="ssh"
export RSYNC_RSH="ssh"
export PYTHONSTARTUP="$HOME/.pythonrc.py"
export HISTCONTROL="ignoredups"

# Local customisations
[ -f ~/.bash_profile_local ] && source ~/.bash_profile_local

# Never want to override this, and we want ~/bin at the front of PATH
export PATH="$(echo "$PATH" | sed -e 's/:.:/:/g')"
export PATH="$HOME/bin:$PATH"

# Interactive mode stuff
[ -r ~/.bashrc    ] && source ~/.bashrc

