#LOAD_START=$(perl -MTime::HiRes -e 'print int(1000 * Time::HiRes::gettimeofday),"\n"')

# Environment
export DOT_DEBUG=false
export DOTFILES="${HOME}/.dotfiles"
export FPATH="$HOME/.dotfiles/zfunc:$FPATH"
export EDITOR=vim
export LESSHISTFILE=/dev/null
export MYSQL_HISTFILE=/dev/null

PATHS=(
"/bin"
"/usr/bin"
"/usr/local/bin"
"/sbin"
"/usr/sbin"
"/usr/local/sbin"
"${HOME}/.cabal/bin"
"${HOME}/.rvm/bin"
"${HOME}/.local/bin"
"${HOME}/.composer/vendor/bin"
"${HOME}/Code/Work/development-tools/bin"
"${HOME}/Library/Python/2.7/bin"
"${HOME}/Library/Python/3.5/bin"
"${HOME}/Library/Android/sdk/platform-tools"
"${DOTFILES}/bin"
"/usr/local/opt/python-2.7.10/bin"
"/usr/local/opt/python-3.5.1/bin"
"/usr/local/opt/ruby-2.2.3/bin"
"/usr/local/opt/lua-5.3.2/bin"
"/usr/local/opt/neovim/bin"
"/usr/local/opt/tmux-2.1/bin"
"${HOME}/.gem/ruby/2.2.0/bin"
)

if type brew &> /dev/null; then
    PATHS+=(
    "$(brew --prefix homebrew/php/php53)/bin"
    "$(brew --prefix ruby)/bin"
    )
fi

for ELEMENT in "${PATHS[@]}"; do
    if [ ! "${ELEMENT}" = "" ]; then
        if [ -d "${ELEMENT}" ]; then
            PATH="${ELEMENT}:${PATH}"
        fi
    fi
done

export PATH
export MANPATH="${MANPATH}:/usr/local/man"

OPERATING_SYSTEM=$(uname)

if type python3 &> /dev/null; then
    SITE_PACKAGES=$(python3 -m site --user-site)
else
    # Fallback for systems without python in /usr/local/opt/python-3.5.0.
    SITE_PACKAGES=$(python -m site --user-site)
fi

export POWERLINE_DIRECTORY="${SITE_PACKAGES}/powerline"

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
    if ! type powerline &> /dev/null; then
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

# Use GNU commands on OS X if they exist.
if type gdircolors &> /dev/null; then
    DIRCOLORS_COMMAND='gdircolors'
else
    DIRCOLORS_COMMAND="dircolors"
fi

if type gls &> /dev/null; then
    LS_COMMAND='gls'
else
    LS_COMMAND="ls"
fi

# aliases
. "${HOME}/.aliases"

if type grc &> /dev/null; then
    GRC_CONF="/usr/local/etc/grc.bashrc"

    if [ -f "${GRC_CONF}" ]; then
        . ${GRC_CONF}
    fi

    alias gs="git status | grcat conf.gitstatus"
else
    alias gs="git status"
fi

# Load local config which is private.
ADITION_CONF="${HOME}/.adition.conf"

if [ -f "${ADITION_CONF}" ]; then
    . "${ADITION_CONF}"
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
