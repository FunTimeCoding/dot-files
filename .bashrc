# xquartz fix
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

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

type gdircolors &> /dev/null && DIRCOLORS='gdircolors' || DIRCOLORS="dircolors"
type gls &> /dev/null && LS='gls' || LS="ls"

. "${HOME}/.aliases.sh"

PHPBREW="${HOME}/.phpbrew/bashrc"

if [ -f "${PHPBREW}" ]; then
    . /Users/shiin/.phpbrew/bashrc
fi

case "${TERM}" in
    xterm* | screen*)
        eval $(${DIRCOLORS} "${DOTFILES}/dircolors")
        ;;
esac

# The following string is to prevent modifications by the provisioning system.
# protected
