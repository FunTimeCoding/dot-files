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

# aliases
alias bashrc='vim ~/.bashrc'

if type gls &> /dev/null; then
    alias ls='gls -F --color'
    alias l='ls'
    alias ll='gls -lh --color'
    alias la='gls -Alh --color'
fi
