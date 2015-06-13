#LOAD_START=$(perl -MTime::HiRes -e 'print int(1000 * Time::HiRes::gettimeofday),"\n"')

# env
export DOT_DEBUG=false
export DOTFILES="${HOME}/.dotfiles"
export FPATH="$HOME/.dotfiles/zfunc:$FPATH"
export EDITOR=vim

# completion
autoload -Uz compinit
compinit

# functions
autoload -Uz ~/.dotfiles/zfunc/*(:t)

# powerline
OS=$(uname)

if [ "${OS}" = "Linux" ]; then
    SITE_PACKAGES=$(python -m site --user-site)
    DEBIAN_VERSION=$(cat /etc/debian_version)
elif [ "${OS}" = "Darwin" ]; then
    SITE_PACKAGES="/usr/local/lib/python2.7/site-packages"
fi

if [ "${DEBIAN_VERSION}" = "8.1" ]; then
    export POWERLINE_DIR=/usr/share/powerline
else
    export POWERLINE_DIR="${SITE_PACKAGES}/powerline"
fi

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
"${HOME}/.composer/vendor/bin"
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
[[ -d "${GROOVY_DIR}" ]] && export GROOVY_HOME="${GROOVY_DIR}"

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
alias svn_up_dry='svn merge --dry-run -r BASE:HEAD .'
alias svn_diff='svn diff | view -'
alias zshrc='vim ~/.zshrc'
alias saidar='saidar -c'
alias crontab="VIM_CRONTAB=true crontab"
alias apt-search='apt-cache search'
alias apt-version='dpkg -s'
alias ccat='pygmentize -O style=monokai -f console256 -g'
alias irssi='screenify irssi'
alias i='irssi'
alias iotop='sudo iotop'
alias svn_diff_branch='svn diff -r $(svn log --stop-on-copy | grep -o "^r\d*" | tail -1):HEAD | view -'

if dot_command_exists grcat; then
    alias gst='git status | grcat conf.gitstatus'
else
    alias gst='git status'
fi

ADITION_CONF="${HOME}/.adition.conf"
[[ -f "${ADITION_CONF}" ]] && source "${ADITION_CONF}"

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

# dircolors, powerline
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
