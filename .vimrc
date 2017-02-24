set nocompatible
filetype plugin indent on
set number
set statusline+=%F\ %y
cabbrev W w
cabbrev Q q

if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
else
  set backupdir=~/.vim/backup
  set directory=~/.vim/swap
endif
