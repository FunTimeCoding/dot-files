alias v='\nvim'
alias vim='echo "v"'
alias nvim='echo "v"'
alias vc='\nvim ~/.vim/init.vim'
alias zc='\nvim ~/.zshrc'
alias brc='\nvim ~/.bashrc'
alias bashrc='echo brc'
alias vimrc='echo vc'
alias zshrc='echo zc'
alias l="ls"
alias ls="${LS} -F --color"
alias ll="${LS} -lh --color"
alias la="${LS} -Alh --color"
alias less='less -Q'
alias s='\svn'
alias si='\svn info'
alias sup='\svn up'
alias sc='\svn commit'
alias scm='\svn commit -m'
alias sst='\svn st'
alias sd='\svn diff'
alias svn-log='\svn log -r HEAD:1 -v -l 3 | less'
alias svn-log-branch='\svn log --stop-on-copy'
alias svn-up-dry='\svn merge --dry-run -r BASE:HEAD .'
alias svn-diff='\svn diff | view -'
alias svn-diff-branch='\svn diff -r $(\svn log --stop-on-copy | grep -o "^r[[:digit:]]*" | tail -1):HEAD | view -'
alias t='\tmux -2'
alias saidar='saidar -c'
alias crontab="VIM_CRONTAB=true crontab"
alias apt-search='apt-cache search'
alias apt-version='dpkg -s'
alias ccat='pygmentize -O style=monokai -f console256 -g'
alias iotop='sudo iotop'
alias htop='sudo htop'
alias grep='grep --color=auto --exclude-dir=.git'
alias egrep='egrep --color=auto --exclude-dir=.git'
alias xdebug-enable='export XDEBUG_CONFIG="remote_enable=1 remote_host=127.0.0.1 remote_port=9000"'
alias xdebug-disable='unset XDEBUG_CONFIG'
alias g='git'
alias gh='git history'
alias gbv='git branch -vv'
alias gbd='git branch --delete'
alias gdf='git diff --color | diff-so-fancy'
alias gdc='git diff --cached'
alias gdcf='git diff --cached --color | diff-so-fancy'
alias upd='sudo apt-get update'
alias upg='sudo apt-get upgrade'
alias ash='apt-cache show'
alias ach='apt-cache search'
alias rm='rm -i'
alias df='df -h'
alias j='jobs -l'
alias h='history'
alias mount='mount | column -t'
unalias gst > /dev/null 2>&1

# Copied from Oh-My-Zsh for Bash.
alias gcam='git commit --all --message'
alias gp='git push'
alias gd='git diff'
alias gaa='git add --all'
alias gl='git pull'
alias gb='git branch'

if [ ! "$(command -v grc || true)" = "" ]; then
    alias gs="\git status | grcat conf.gitstatus"
else
    alias gs="\git status"
fi
