# vim:set nolist noet tw=0 ts=4 sw=4 sts=4:

# We run the environment settings for all shells to ensure it's always set up
source "${HOME}/.bash/environment"

# An interactive shell starting bashrc is not a login shell, just run
# interactive setup
if [ -n "${PS1}" ]; then
	source "${HOME}/.bash/interactive"
fi
