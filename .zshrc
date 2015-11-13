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
"${HOME}/.local/dev-tools/bin"
"${HOME}/Library/Python/3.5/bin"
"${HOME}/Library/Android/sdk/platform-tools"
"${DOTFILES}/bin"
"/usr/local/opt/python-3.5.0/bin"
"/usr/local/opt/python-2.7.10/bin"
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

OS=$(uname)

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

# Perlbrew
PERLBREW="${HOME}/perl5/perlbrew/etc/bashrc"
[ -f "${PERLBREW}" ] && source "${PERLBREW}"

# Oh My Zsh
ZSH="${HOME}/.oh-my-zsh"

if [ -d "${ZSH}" ]; then
    if ! type powerline &> /dev/null; then
        export ZSH_THEME="steeef"
    fi

    export DISABLE_AUTO_TITLE=true
    export DISABLE_UPDATE_PROMPT=true

    if [ "${OS}" = "Darwin" ]; then
        plugins=(git svn zsh-syntax-highlighting osx brew)
    else
        plugins=(git svn zsh-syntax-highlighting)
    fi

    source "${ZSH}/oh-my-zsh.sh"
fi

# Groovy
GROOVY_DIRECTORY="/usr/local/opt/groovy/libexec"
[ -d "${GROOVY_DIRECTORY}" ] && export GROOVY_HOME="${GROOVY_DIRECTORY}"

# use GNU commands on OS X if they exist
type gdircolors &> /dev/null && DIRCOLORS_COMMAND='gdircolors' || DIRCOLORS_COMMAND="dircolors"
type gls &> /dev/null && LS_COMMAND='gls' || LS_COMMAND="ls"

# aliases
. "${HOME}/.aliases"

if type grc &> /dev/null; then
    GRC_CONF="/usr/local/etc/grc.bashrc"

    if [ -f "${GRC_CONF}" ]; then
        . ${GRC_CONF}
    fi

    alias gs='git status | grcat conf.gitstatus'
else
    alias gs='git status'
fi

ADITION_CONF="${HOME}/.adition.conf"
[ -f "${ADITION_CONF}" ] && . "${ADITION_CONF}"

# Zsh settings
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

# dircolors, Powerline
case "${TERM}" in
    xterm* | screen*)
        eval $(${DIRCOLORS_COMMAND} "${DOTFILES}/dircolors")

        if type powerline &> /dev/null; then
            POWERLINE_ZSH="${POWERLINE_DIRECTORY}/bindings/zsh/powerline.zsh"
            [ -f "${POWERLINE_ZSH}" ] && . "${POWERLINE_ZSH}"
        fi
        ;;
esac

# reapply dircolors for tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# lunchy
#LUNCHY_DIRECTORY=$(dirname `gem which lunchy`)/../extras
#LUNCHY_ZSH="${LUNCHY_DIRECTORY}/lunchy-completion.zsh"
#[ -f "${LUNCHY_ZSH}" ] && . "${LUNCHY_ZSH}"

if [ "${OS}" = "Linux" ]; then
    if [ ! "$(pgrep kwalletd5)" = "" ]; then
        if [ "$(ssh-add -l)" = "The agent has no identities." ]; then
            ssh-add < /dev/null
        fi
    fi
fi

#LOAD_END=$(perl -MTime::HiRes -e 'print int(1000 * Time::HiRes::gettimeofday),"\n"')
#echo "Load: $(expr $LOAD_END - $LOAD_START)ms"
