#LOAD_START=$(perl -MTime::HiRes -e 'print int(1000 * Time::HiRes::gettimeofday),"\n"')

export DOT_DEBUG=true
export DOTFILES="${HOME}/.dotfiles"
export FPATH="$HOME/.dotfiles/zfunc:$FPATH"
export EDITOR=vim

# completion
autoload -Uz compinit
compinit

# functions
autoload -Uz ~/.dotfiles/zfunc/*(:t)

# path
PATHS=(
"/bin"
"/usr/bin"
"/usr/local/bin"
"/sbin"
"/usr/sbin"
"/usr/local/sbin"
"/Applications/Xcode.app/Contents/Developer/usr/subversion-1.6/bin"
"${HOME}/.rvm/bin"
"${HOME}/.local/bin"
"${HOME}/.local/php/vendor/bin"
"${HOME}/.local/arcanist/bin"
"${DOTFILES}/bin"
)
for ELEMENT in "${PATHS[@]}"; do
    if [ ! "${ELEMENT}" = "" ]; then
        if dot_dir_exists "${ELEMENT}"; then
            PATH="${ELEMENT}:${PATH}"
        fi
    fi
done
export PATH

# oh-my-zsh
export DISABLE_AUTO_TITLE=true
export DISABLE_UPDATE_PROMPT=true
ZSH="${HOME}/.oh-my-zsh"
plugins=(git osx svn brew)
source "${ZSH}/oh-my-zsh.sh"

# aliases
if dot_command_exists gls; then
    alias ls='gls -F --color'
    alias l='ls'
    alias ll='gls -lh --color'
    alias la='gls -Alh --color'
fi
dot_command_exists nvim && alias vim='nvim'
dot_command_exists gdircolors && alias dircolors='gdircolors'
alias vimrc='vim ~/.vimrc'
alias svn_log='svn log -r HEAD:1 -v -l 3 | less'
alias svn_diff='svn diff | view -'
alias zshrc='vim ~/.zshrc'
alias saidar='saidar -c'
alias crontab="VIM_CRONTAB=true crontab"
alias apt-search='apt-cache search'
alias apt-version='dpkg -s'

# zsh settings
CASE_SENSITIVE="true"
HISTFILE=~/.zsh_history
SAVEHIST=1000
HISTSIZE=1000
setopt incappendhistory
setopt histignoredups
setopt INTERACTIVE_COMMENTS # enable # comments in commands
unsetopt NOMATCH # disable "zsh: no matches found" errors caused by **
bindkey -v # vi-mode
bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# dircolors & powerline
case "${TERM}" in
    xterm* | screen*)
        eval $(dircolors "${DOTFILES}/dircolors")

        if dot_command_exists powerline; then
            POWERLINE="${DOTFILES}/.local/powerline/powerline/bindings/zsh/powerline.zsh"
            [ -f "${POWERLINE}" ] && . "${POWERLINE}"
        else
            echo "powerline is missing"
        fi
        ;;
esac

# syntax highlight
ZSH_SYNTAX_HIGHLIGHT="${DOTFILES}/.local/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -f "${ZSH_SYNTAX_HIGHLIGHT}" ] && source "${ZSH_SYNTAX_HIGHLIGHT}"

# reapply dircolors for tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

#LOAD_END=$(perl -MTime::HiRes -e 'print int(1000 * Time::HiRes::gettimeofday),"\n"')
#echo "Load: $(expr $LOAD_END - $LOAD_START)ms"
