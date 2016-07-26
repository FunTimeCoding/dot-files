export DOTFILES="${HOME}/.dotfiles"
export FPATH="$HOME/.dotfiles/zfunc:$FPATH"
export EDITOR=vim
export LESSHISTFILE=/dev/null
export MYSQL_HISTFILE=/dev/null
export LD_LIBRARY_PATH="${HOME}/lib"
PATHS_CONFIG="${HOME}/.paths.conf"

if [ -f "${PATHS_CONFIG}" ]; then
    . "${PATHS_CONFIG}"
fi

LOCAL_CONFIG="${HOME}/.local.conf"

if [ -f "${LOCAL_CONFIG}" ]; then
    . "${LOCAL_CONFIG}"
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

if [ ! "${VTE_VERSION}" = "" ]; then
    export TERM=xterm-256color
fi

PERLBREW="${HOME}/perl5/perlbrew/etc/bashrc"

if [ -f "${PERLBREW}" ]; then
    . "${PERLBREW}"
fi

PHPBREW="${HOME}/.phpbrew/bashrc"

if [ -f "${PHPBREW}" ]; then
    . "${PHPBREW}"
fi

ZSH="${HOME}/.oh-my-zsh"

if [ -d "${ZSH}" ]; then
    if [ "$(command -v powerline || true)" = "" ]; then
        export ZSH_THEME="steeef"
    fi

    export DISABLE_AUTO_TITLE=true
    export DISABLE_UPDATE_PROMPT=true

    if [ -f /etc/debian_version ]; then
        VERSION=$(cut -c 1-1 < /etc/debian_version)

        if [ "${VERSION}" = 6 ]; then
            plugins=(git)
        else
            plugins=(git zsh-syntax-highlighting)
        fi
    else
        plugins=(git zsh-syntax-highlighting)
    fi

    . "${ZSH}/oh-my-zsh.sh"
fi

GROOVY_DIRECTORY=/usr/local/opt/groovy/libexec

if [ -d "${GROOVY_DIRECTORY}" ]; then
    export GROOVY_HOME="${GROOVY_DIRECTORY}"
fi

if [ "$(command -v gdircolors || true)" = "" ]; then
    DIRCOLORS=dircolors
else
    DIRCOLORS=gdircolors
fi

if [ "$(command -v gls || true)" = "" ]; then
    LS=ls
else
    LS=gls
fi

if [ ! "$(command -v grc || true)" = "" ]; then
    GRC_CONFIG=/usr/local/etc/grc.bashrc

    if [ -f "${GRC_CONFIG}" ]; then
        . ${GRC_CONFIG}
    fi
fi

CASE_SENSITIVE=true
SAVEHIST=1000
HISTSIZE=1000
HISTFILE=~/.zsh_history
setopt incappendhistory
setopt histignoredups
# Allow pound character comments in commands
setopt interactive_comments
setopt nobeep
# Disable 'zsh: no matches found' errors caused by **
unsetopt nomatch
# Enable vi mode
bindkey -v
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^r' history-incremental-search-backward

case "${TERM}" in
    xterm* | screen*)
        eval $(${DIRCOLORS} "${DOTFILES}/dircolors")

        if type powerline &> /dev/null; then
            POWERLINE_ZSH="${POWERLINE_DIRECTORY}/bindings/zsh/powerline.zsh"

            if [ -f "${POWERLINE_ZSH}" ]; then
                . "${POWERLINE_ZSH}"
            fi
        fi
        ;;
esac

. "${HOME}/.aliases"

# Reapply list colors.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
