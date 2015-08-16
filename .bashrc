# xquartz fix
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

# env
export DOTFILES="${HOME}/.dotfiles"

# aliases
alias bashrc='vim ~/.bashrc'
type gdircolors &> /dev/null && DIRCOLORS_COMMAND='gdircolors' || DIRCOLORS_COMMAND="dircolors"

# dircolors
case "${TERM}" in
    xterm* | screen*)
        eval $(${DIRCOLORS_COMMAND} "${DOTFILES}/dircolors")
        ;;
esac

# bash configuration
unset HISTFILE

if type gls &> /dev/null; then
    alias ls='gls -F --color'
    alias l='ls'
    alias ll='gls -lh --color'
    alias la='gls -Alh --color'
fi
