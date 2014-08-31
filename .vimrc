" neobundle setup
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" list of bundles
NeoBundle 'tpope/vim-sensible'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" end of neobundle setup

set number
syntax enable
