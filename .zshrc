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

OS=$(uname)
if [ "${OS}" = "Linux" ]; then
    SITE_PACKAGES=$(python -m site --user-site)
elif [ "${OS}" = "Darwin" ]; then
    SITE_PACKAGES="/usr/local/lib/python2.7/site-packages"
fi

export POWERLINE_DIR="${SITE_PACKAGES}/powerline"

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
"${HOME}/.local/dev-tools/bin"
"${DOTFILES}/bin"
"${POWERLINE_DIR}/bin"
)

if dot_command_exists brew; then
    PATHS+=(
    "$(brew --prefix homebrew/php/php53)/bin"
    "$(brew --prefix ruby)/bin"
    )
fi
for ELEMENT in "${PATHS[@]}"; do
    if [ ! "${ELEMENT}" = "" ]; then
        if dot_dir_exists "${ELEMENT}"; then
            PATH="${ELEMENT}:${PATH}"
        fi
    fi
done
export PATH
export MANPATH="${MANPATH}:/usr/local/man"

# perlbrew
PERLBREW="${HOME}/perl5/perlbrew/etc/bashrc"
[[ -f "${PERLBREW}" ]] && source "${PERLBREW}"

# oh-my-zsh
ZSH="${HOME}/.oh-my-zsh"
if [ -d "${ZSH}" ]; then
    if ! dot_command_exists powerline; then
        export ZSH_THEME="steeef"
    fi
    export DISABLE_AUTO_TITLE=true
    export DISABLE_UPDATE_PROMPT=true
    if [ "${OS}" = "Linux" ]; then
        plugins=(git svn zsh-syntax-highlighting)
    elif [ "${OS}" = "Darwin" ]; then
        plugins=(git osx svn brew zsh-syntax-highlighting)
    fi
    source "${ZSH}/oh-my-zsh.sh"
fi

# groovy
GROOVY_DIR="/usr/local/opt/groovy/libexec"
if [ -d "${GROOVY_DIR}" ]; then
    export "GROOVY_HOME=${GROOVY_DIR}"
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
alias ccat='pygmentize -O style=monokai -f console256 -g'
if dot_command_exists grcat; then
    alias gst='git status | grcat conf.gitstatus'
else
    alias gst='git status'
fi

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
                POWERLINE_ZSH="${POWERLINE_DIR}/bindings/zsh/powerline.zsh"
                [ -f "${POWERLINE_ZSH}" ] && . "${POWERLINE_ZSH}"
            fi
            ;;
    esac
fi

# reapply dircolors for tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

#LOAD_END=$(perl -MTime::HiRes -e 'print int(1000 * Time::HiRes::gettimeofday),"\n"')
#echo "Load: $(expr $LOAD_END - $LOAD_START)ms"
