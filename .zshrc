#LOAD_START=$(perl -MTime::HiRes -e 'print int(1000 * Time::HiRes::gettimeofday),"\n"')

export DOT_DEBUG=false
export DOTFILES="${HOME}/.dotfiles"
export FPATH="$HOME/.dotfiles/zfunc:$FPATH"
export EDITOR=vim

# completion
autoload -Uz compinit
compinit

# functions
autoload -Uz ~/.dotfiles/zfunc/*(:t)

#POWERLINE_PATH="$(find /usr/local/lib/python2.7/site-packages -type d -name 'powerline*' -maxdepth 1)"

# path
PATHS=(
"/bin"
"/usr/bin"
"/usr/local/bin"
"/sbin"
"/usr/sbin"
"/usr/local/sbin"
"${HOME}/.rvm/bin"
"${HOME}/.local/bin"
"${HOME}/.local/php/bin"
"${DOTFILES}/bin"
"$(brew --prefix homebrew/php/php56)/bin"
"$(brew --prefix ruby)/bin"
#"${POWERLINE_PATH}/bin"
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
ZSH="${HOME}/.oh-my-zsh"
if [ -d "${ZSH}" ]; then
    if ! dot_command_exists powerline; then
        export ZSH_THEME="steeef"
    fi
    export DISABLE_AUTO_TITLE=true
    export DISABLE_UPDATE_PROMPT=true
    plugins=(git osx svn brew)
    source "${ZSH}/oh-my-zsh.sh"
fi

# aliases
if dot_command_exists gls; then
    alias ls='gls -F --color'
    alias l='ls'
    alias ll='gls -lh --color'
    alias la='gls -Alh --color'
fi
# dot_command_exists nvim && alias vim='nvim'
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
setopt nobeep
unsetopt NOMATCH # disable "zsh: no matches found" errors caused by **
bindkey -v # vi-mode
bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# dircolors & powerline
if dot_command_exists dircolors; then
    case "${TERM}" in
        xterm* | screen*)
            eval $(dircolors "${DOTFILES}/dircolors")

            if dot_command_exists powerline; then
                POWERLINE_LINUX_26="${HOME}/.local/lib/python2.6/site-packages/powerline/bindings/zsh/powerline.zsh"
                [ -f "${POWERLINE_LINUX_26}" ] && . "${POWERLINE_LINUX_26}"
                POWERLINE_LINUX_27="${HOME}/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh"
                [ -f "${POWERLINE_LINUX_27}" ] && . "${POWERLINE_LINUX_27}"
                #POWERLINE_OSX="/usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh"
                #POWERLINE_OSX="${POWERLINE_PATH}/powerline/bindings/zsh/powerline.zsh"
                #[ -f "${POWERLINE_OSX}" ] && . "${POWERLINE_OSX}"
            fi
            ;;
    esac
fi

# syntax highlight
ZSH_SYNTAX_HIGHLIGHT="${HOME}/.local/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -f "${ZSH_SYNTAX_HIGHLIGHT}" ] && source "${ZSH_SYNTAX_HIGHLIGHT}"

# reapply dircolors for tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

#LOAD_END=$(perl -MTime::HiRes -e 'print int(1000 * Time::HiRes::gettimeofday),"\n"')
#echo "Load: $(expr $LOAD_END - $LOAD_START)ms"
