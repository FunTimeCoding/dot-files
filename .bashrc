# xquartz fix
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

# env
export DOTFILES="${HOME}/.dotfiles"
PATHS_CONFIG="${HOME}/.paths.conf"

if [ -f "${PATHS_CONFIG}" ]; then
    . "${PATHS_CONFIG}"
fi

while read -r LINE; do
    if [ -d "${LINE}" ]; then
        PATH="${LINE}:${PATH}"
    fi
done <<< "${PATHS}"

export PATH

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
