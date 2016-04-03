#LOAD_START=$(perl -MTime::HiRes -e 'print int(1000 * Time::HiRes::gettimeofday),"\n"')

# Environment
export DOT_DEBUG=false
export DOTFILES="${HOME}/.dotfiles"
export FPATH="$HOME/.dotfiles/zfunc:$FPATH"
export EDITOR=vim
export LESSHISTFILE=/dev/null
export MYSQL_HISTFILE=/dev/null

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
export MANPATH="${MANPATH}:/usr/local/man"

OPERATING_SYSTEM=$(uname)

if [ ! "$(command -v python3 || true)" = "" ]; then
    SITE_PACKAGES=$(python3 -m site --user-site)
    export POWERLINE_DIRECTORY="${SITE_PACKAGES}/powerline"
fi

# Completion
autoload -Uz compinit
compinit

# User functions
autoload -Uz ~/.dotfiles/zfunc/*(:t)

if [ "$COLORTERM" = "gnome-terminal" ]; then
    export TERM="xterm-256color"
fi

# Perlbrew
PERLBREW="${HOME}/perl5/perlbrew/etc/bashrc"

if [ -f "${PERLBREW}" ]; then
    . "${PERLBREW}"
fi

# Oh My Zsh
ZSH="${HOME}/.oh-my-zsh"

if [ -d "${ZSH}" ]; then
    if [ "$(command -v powerline || true)" = "" ]; then
        export ZSH_THEME="steeef"
    fi

    export DISABLE_AUTO_TITLE=true
    export DISABLE_UPDATE_PROMPT=true

    if [ "${OPERATING_SYSTEM}" = "Darwin" ]; then
        plugins=(git svn zsh-syntax-highlighting osx brew)
    else
        if [ -f "/etc/arch-release" ]; then
            plugins=(git)
        else
            plugins=(git svn zsh-syntax-highlighting)
        fi
    fi

    source "${ZSH}/oh-my-zsh.sh"
fi

# Groovy
GROOVY_DIRECTORY="/usr/local/opt/groovy/libexec"

if [ -d "${GROOVY_DIRECTORY}" ]; then
    export GROOVY_HOME="${GROOVY_DIRECTORY}"
fi

# Use GNU commands on OS X, if they exist.
if [ "$(command -v gdircolors || true)" = "" ]; then
    DIRCOLORS_COMMAND="dircolors"
else
    DIRCOLORS_COMMAND='gdircolors'
fi

if [ ! "$(command -v gls || true)" = "" ]; then
    LS_COMMAND='gls'
else
    LS_COMMAND="ls"
fi

# aliases
. "${HOME}/.aliases"

if [ ! "$(command -v grc || true)" = "" ]; then
    GRC_CONF="/usr/local/etc/grc.bashrc"

    if [ -f "${GRC_CONF}" ]; then
        . ${GRC_CONF}
    fi

    alias gs="git status | grcat conf.gitstatus"
else
    alias gs="git status"
fi

# Load local config.
LOCAL_CONF="${HOME}/.local.conf"

if [ -f "${LOCAL_CONF}" ]; then
    . "${LOCAL_CONF}"
fi

# Zsh
CASE_SENSITIVE="true"
SAVEHIST=1000
HISTSIZE=1000
setopt incappendhistory
setopt histignoredups
setopt INTERACTIVE_COMMENTS # allow pound character comments in commands
setopt nobeep
unsetopt NOMATCH # disable 'zsh: no matches found' errors caused by **
bindkey -v # vi-mode
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

#if type hh &> /dev/null; then
#    export HISTFILE=~/.zsh_history
#    export HH_CONFIG=hicolor # get more colors
#    bindkey -s "\C-r" "\eihh\n" # bind hh to Ctrl-r (for Vi mode check doc)
#else
HISTFILE=~/.zsh_history
bindkey '^r' history-incremental-search-backward
#fi

# dircolors, Powerline
case "${TERM}" in
    xterm* | screen*)
        eval $(${DIRCOLORS_COMMAND} "${DOTFILES}/dircolors")

        if type powerline &> /dev/null; then
            POWERLINE_ZSH="${POWERLINE_DIRECTORY}/bindings/zsh/powerline.zsh"

            if [ -f "${POWERLINE_ZSH}" ]; then
                . "${POWERLINE_ZSH}"
            fi
        fi
        ;;
esac

# Re-apply dircolors for tab completion.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Lunchy
#LUNCHY_DIRECTORY=$(dirname `gem which lunchy`)/../extras
#LUNCHY_ZSH="${LUNCHY_DIRECTORY}/lunchy-completion.zsh"
#
#if [ -f "${LUNCHY_ZSH}" ]; then
#    . "${LUNCHY_ZSH}"
#fi

# Add keys to ssh-agent on KDE 5.
if [ "${OPERATING_SYSTEM}" = "Linux" ]; then
    if [ ! "$(pgrep kwalletd5)" = "" ]; then
        if [ "$(ssh-add -l)" = "The agent has no identities." ]; then
            export SSH_ASKPASS="/usr/bin/ksshaskpass"
            ssh-add < /dev/null
        fi
    fi
fi

#LOAD_END=$(perl -MTime::HiRes -e 'print int(1000 * Time::HiRes::gettimeofday),"\n"')
#echo "Loading time: $(expr $LOAD_END - $LOAD_START)ms"
