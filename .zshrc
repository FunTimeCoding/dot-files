if [ -d "${HOME}/src/dotfiles" ]; then
    export FPATH="${HOME}/src/dotfiles/zfunc:${FPATH}"
elif [ -d "${HOME}/.dotfiles" ]; then
    export FPATH="${HOME}/.dotfiles/zfunc:${FPATH}"
fi

export EDITOR=vim
export LESSHISTFILE=/dev/null
export MYSQL_HISTFILE=/dev/null
export LD_LIBRARY_PATH="${HOME}/lib"
PATHS_CONFIG="${HOME}/.paths.sh"

if [ -f "${HOME}/.paths.sh" ]; then
    . "${HOME}/.paths.sh"
fi

LOCAL_CONFIG="${HOME}/.local.sh"

if [ -f "${HOME}/.local.sh" ]; then
    . "${HOME}/.local.sh"
fi

unset PATH

while read -r LINE; do
    if [ -d "${LINE}" ]; then
        if [ "${PATH}" = "" ]; then
            PATH="${LINE}"
        else
            PATH="${LINE}:${PATH}"
        fi
    fi
done <<< "${PATHS}"

export PATH
export MANPATH="${MANPATH}:/usr/local/man"
SYSTEM=$(uname)

if [ ! "$(command -v python3 || true)" = "" ]; then
    if [ "${SYSTEM}" = Darwin ]; then
        SITE_PACKAGES=/usr/local/lib/python3.6/site-packages
    else
        SITE_PACKAGES=$(python3 -m site --user-site)
    fi

    export POWERLINE_DIRECTORY="${SITE_PACKAGES}/powerline"
fi

# Completion
autoload -Uz compinit
compinit

# User functions
if [ -d "${HOME}/src/dotfiles" ]; then
    autoload -Uz ~/src/dotfiles/zfunc/*(:t)
elif [ -d "${HOME}/.dotfiles" ]; then
    autoload -Uz ~/.dotfiles/zfunc/*(:t)
fi

if [ ! "${VTE_VERSION}" = "" ]; then
    export TERM=xterm-256color
fi

if [ -f "${HOME}/perl5/perlbrew/etc/bashrc" ]; then
    . "${HOME}/perl5/perlbrew/etc/bashrc"
fi

if [ -f "${HOME}/.phpbrew/bashrc" ]; then
    . "${HOME}/.phpbrew/bashrc"
fi

ZSH="${HOME}/.oh-my-zsh"

if [ -d "${ZSH}" ]; then
    if [ "$(command -v powerline || true)" = "" ]; then
        export ZSH_THEME=steeef
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

if [ -d /usr/local/opt/groovy/libexec ]; then
    export GROOVY_HOME=/usr/local/opt/groovy/libexec
fi

if [ -f "$HOME/.rvm/scripts/rvm" ]; then
    source "$HOME/.rvm/scripts/rvm"
fi

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

#if [ ! "$(command -v grc || true)" = "" ]; then
#    if [ -f /usr/local/etc/grc.bashrc ]; then
#        . /usr/local/etc/grc.bashrc
#    fi
#fi

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
        if [ ! "$(command -v ${DIRCOLORS} || true)" = "" ]; then
            if [ -d "${HOME}/src/dotfiles" ]; then
                eval $(${DIRCOLORS} "${HOME}/src/dotfiles/dircolors")
            elif [ -d "${HOME}/.dotfiles" ]; then
                eval $(${DIRCOLORS} "${HOME}/.dotfiles/dircolors")
            fi
        fi

        if type powerline &> /dev/null; then
            POWERLINE_ZSH="${POWERLINE_DIRECTORY}/bindings/zsh/powerline.zsh"

            if [ -f "${POWERLINE_ZSH}" ] && [ ! "${TERM_PROGRAM}" = Apple_Terminal ]; then
                . "${POWERLINE_ZSH}"
            fi
        fi
        ;;
esac

# Must be after DIRCOLORS and LS are sorted out.
. "${HOME}/.aliases.sh"

# Reapply list colors.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
