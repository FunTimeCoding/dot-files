alias v='\nvim'
alias vim='echo v'
alias nvim='echo v'
alias vc='\nvim ~/.config/nvim/init.vim'
alias zc='\nvim ~/.zshrc'
alias brc='\nvim ~/.bashrc'
alias bashrc='echo brc'
alias vimrc='echo vc'
alias zshrc='echo zc'
alias sf='php symfony'
alias l=ls

if [ "${GNU_LS_FOUND}" = true ]; then
    alias ls="${LS} -F --color"
    alias ll="${LS} -lh --color"
    alias la="${LS} -Alh --color"
fi

alias less='less -Q'
alias t='\tmux -2'
alias saidar='saidar -c'
alias crontab="VIM_CRONTAB=true crontab"
alias acs='apt-cache search'
alias ds='dpkg -s'
alias ccat='pygmentize -O style=monokai -f console256 -g'
alias iotop='sudo iotop'
alias grep='grep --color=auto --exclude-dir=.git'
alias egrep='egrep --color=auto --exclude-dir=.git'
alias xdebug-enable='export XDEBUG_CONFIG="remote_enable=1 remote_host=127.0.0.1 remote_port=9000"'
alias xdebug-disable='unset XDEBUG_CONFIG'
alias g=git
alias gh='git history'
alias gbv='git branch -vv'
alias gbd='git branch --delete'
alias gdf='git diff --color | diff-so-fancy'
alias gdc='git diff --cached'
alias gdcf='git diff --cached --color | diff-so-fancy'
alias gct='git checkout --track'
alias gcb='git checkout -b'
alias upd='sudo apt-get update'
alias upg='sudo apt-get upgrade'
alias ash='apt-cache show'
alias ach='apt-cache search'
alias rm='rm -i'
alias df='df -h'
alias j='jobs -l'
alias h=history
alias mount='mount | column -t'
unalias gst > /dev/null 2>&1
alias va=vagrant
alias vs='vagrant status'
alias vss='vagrant ssh'
alias vgs='vagrant global-status'
alias vu='vagrant up'
alias vh='vagrant halt'
alias vd='vagrant destroy'
alias vp='vagrant provision'
alias vps='vagrant provision --provision-with salt'
alias vpa='vagrant provision --provision-with ansible'
alias vdf='vagrant destroy --force'
alias sch='sudo salt-call state.highstate'
alias schm='sudo salt-call --state-output=mixed state.highstate'
alias schvf='sudo salt-call --state-verbose=False state.highstate'
alias scht='sudo salt-call state.highstate test=True'
alias schmt='sudo salt-call --state-output=mixed state.highstate test=True'
alias schvft='sudo salt-call --state-verbose=False state.highstate test=True'

# Copied from Oh-My-Zsh for Bash.
alias gcam='git commit --all --message'
alias gp='git push'
alias gd='git diff'
alias gdmd='gd master..develop'
alias ga='git add'
alias gaa='git add --all'
alias gm='git merge'
alias gl='git pull'
alias gb='git branch'
alias gba='git branch --all'
alias grv='git remote --verbose'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gco='git checkout'
alias gc='git commit'

if [ ! "$(command -v grc || true)" = "" ]; then
    alias gs="\git status | grcat conf.gitstatus"
else
    alias gs="\git status"
fi

alias xdon='phpbrew ext enable xdebug'
alias xdoff='phpbrew ext disable xdebug'

alias kubectl='echo k'
alias k='\kubectl'

alias mcc='./mvnw clean install sonar:sonar'

alias docker='echo d'
alias d='\docker'
alias dp='\docker ps'
alias dl='\docker ps --format "{{.Names}}"'
alias dpa='\docker ps --all'
alias dr='\docker rm'
alias drf='\docker rm --force'

alias docker-compose='echo dc'
alias dc='\docker-compose'
alias dcu='\docker-compose up'
alias dcd='\docker-compose down'
alias dcp='\docker-compose ps'
