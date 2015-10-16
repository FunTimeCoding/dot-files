# xquartz fix
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

# env
export DOTFILES="${HOME}/.dotfiles"
export PATH="${HOME}/.local/bin:/usr/local/opt/python-3.5.0/bin:/usr/local/opt/python-2.7.10/bin:${PATH}"

# osx commmand forks
type gdircolors &> /dev/null && DIRCOLORS_COMMAND='gdircolors' || DIRCOLORS_COMMAND="dircolors"
type gls &> /dev/null && LS_COMMAND='gls' || LS_COMMAND="ls"

# aliases
. "${HOME}/.aliases"

# dircolors
case "${TERM}" in
    xterm* | screen*)
        eval $(${DIRCOLORS_COMMAND} "${DOTFILES}/dircolors")
        ;;
esac

# bash configuration
#unset HISTFILE

# The following string is to prevent modifications by the provisioning system.
# protected
