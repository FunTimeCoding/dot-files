# xquartz needs LC_ALL and LANG
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

if [ -f "${HOME}/.paths.sh" ]; then
    . "${HOME}/.paths.sh"
fi

while read -r LINE; do
    if [ -d "${LINE}" ]; then
        PATH="${LINE}:${PATH}"
    fi
done <<< "${PATHS}"

export PATH
SYSTEM=$(uname)
LS=ls
GNU_LS_FOUND=false

if [ "${SYSTEM}" = Darwin ]; then
    DIRCOLORS=gdircolors

    if [ ! "$(command -v gls || true)" = "" ]; then
        LS=gls
        GNU_LS_FOUND=true
    fi
else
    DIRCOLORS=dircolors
    GNU_LS_FOUND=true
fi

. "${HOME}/.aliases.sh"

if [ -f "${HOME}/.phpbrew/bashrc" ]; then
    . "${HOME}/.phpbrew/bashrc"
fi

case "${TERM}" in
    xterm* | screen*)
        if [ ! "$(command -v ${DIRCOLORS} || true)" = "" ]; then
            eval $(${DIRCOLORS} "${HOME}/src/dot-files/dircolors")
        fi
        ;;
esac

# The following line is to prevent modifications by the provisioning system.
# protected
