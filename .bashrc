# xquartz fix
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

# env
export DOTFILES="${HOME}/.dotfiles"

# dircolors
case "${TERM}" in
    xterm* | screen*)
        eval $(/usr/local/bin/gdircolors "${DOTFILES}/dircolors")
        ;;
esac
