if [ -d "${HOME}/src/dot-files" ]; then
    FPATH="${HOME}/src/dot-files/zfunc:${FPATH}"
elif [ -d "${HOME}/.dot-files" ]; then
    FPATH="${HOME}/.dot-files/zfunc:${FPATH}"
fi

EDITOR=vim
LESSHISTFILE=/dev/null
MYSQL_HISTFILE=/dev/null
LD_LIBRARY_PATH="${HOME}/lib"
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

MANPATH="${MANPATH}:/usr/local/man"
SYSTEM=$(uname)

if [ ! "$(command -v python3 || true)" = "" ]; then
    if [ "${SYSTEM}" = Darwin ]; then
        POWERLINE_DIRECTORY=/usr/local/lib/python3.6/site-packages/powerline
    elif [ ! "$(command -v lsb_release || true)" = "" ]; then
        CODENAME=$(lsb_release --codename --short)

        if [ "${CODENAME}" = trusty ]; then
            POWERLINE_DIRECTORY=/usr/local/lib/python3.4/dist-packages/powerline
        elif [ "${CODENAME}" = jessie ]; then
            if [ -d "${HOME}/opt/python-3.5.1" ]; then
                POWERLINE_DIRECTORY="${HOME}/.local/lib/python3.5/site-packages/powerline"
            else
                POWERLINE_DIRECTORY=/usr/local/lib/python3.4/dist-packages/powerline
            fi
        elif [ "${CODENAME}" = stretch ]; then
            POWERLINE_DIRECTORY=/usr/share/powerline
        fi
    fi

    # for tmux
    export POWERLINE_DIRECTORY
fi

# Completion
autoload -Uz compinit
compinit

# User functions
if [ -d "${HOME}/src/dot-files" ]; then
    autoload -Uz ~/src/dot-files/zfunc/*(:t)
elif [ -d "${HOME}/.dot-files" ]; then
    autoload -Uz ~/.dot-files/zfunc/*(:t)
fi

if [ ! "${VTE_VERSION}" = "" ]; then
    TERM=xterm-256color
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
        ZSH_THEME=steeef
    fi

    DISABLE_AUTO_TITLE=true
    DISABLE_UPDATE_PROMPT=true

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
    GROOVY_HOME=/usr/local/opt/groovy/libexec
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
KEYTIMEOUT=1
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
bindkey '^[^[[C' forward-word
bindkey '^[^[[D' backward-word
bindkey '^r' history-incremental-search-backward
bindkey '^w' backward-kill-word

case "${TERM}" in
    xterm* | screen*)
        if [ ! "$(command -v ${DIRCOLORS} || true)" = "" ]; then
            if [ -d "${HOME}/src/dot-files" ]; then
                eval $(${DIRCOLORS} "${HOME}/src/dot-files/dircolors")
            elif [ -d "${HOME}/.dot-files" ]; then
                eval $(${DIRCOLORS} "${HOME}/.dot-files/dircolors")
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
