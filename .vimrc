" neobundle setup
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" bundles list
NeoBundle 'tpope/vim-sensible'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'bling/vim-airline'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'chase/vim-ansible-yaml'
NeoBundle 'tejr/vim-nagios'
NeoBundle 'saltstack/salt-vim'
NeoBundle 'Glench/Vim-Jinja2-Syntax'
NeoBundle 'othree/html5.vim'
NeoBundle 'Keithbsmiley/swift.vim'
NeoBundle 'derekwyatt/vim-scala'
NeoBundleLazy 'docker/docker', {'rtp': 'contrib/syntax/vim/', 'autoload': {'filetypes' : ['dockerfile']}}
NeoBundleLazy 'mfukar/robotframework-vim', {'autoload': {'filetypes' : ['robot']}}
NeoBundleLazy 'pangloss/vim-javascript', {'autoload': {'filetypes' : ['javascript']}}
NeoBundleLazy 'nginx/nginx', {'rtp': 'contrib/vim/', 'autoload': {'filetypes' : ['nginx']}}

let s:php_plugins = ['StanAngeloff/php.vim', 'joonty/vim-phpqa', '2072/PHP-Indenting-for-VIm']
for g:plugin in s:php_plugins
    NeoBundleLazy g:plugin, {'autoload' : { 'filetypes' : ['php'] }}
endfor
unlet s:php_plugins

let s:ruby_plugins = ['vim-ruby/vim-ruby', 'thoughtbot/vim-rspec']
for g:plugin in s:ruby_plugins
    NeoBundleLazy g:plugin, {'autoload' : { 'filetypes' : ['ruby'] }}
endfor
unlet s:ruby_plugins

let s:python_plugins = ['klen/python-mode', 'nvie/vim-flake8']
for g:plugin in s:python_plugins
    NeoBundleLazy g:plugin, {'autoload' : { 'filetypes' : ['python'] }}
endfor
unlet s:python_plugins

let s:erlang_plugins = ['edkolev/erlang-motions.vim', 'jimenezrick/vimerl']
for g:plugin in s:erlang_plugins
    NeoBundleLazy g:plugin, {'autoload' : { 'filetypes' : ['erlang'] }}
endfor
unlet s:erlang_plugins

unlet g:plugin
" end of bundles list

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" end of neobundle setup

set number
syntax enable

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"set noerrorbells
set vb t_vb=

cabbrev W w
cabbrev Q q
let mapleader=","

set backupdir=~/.vim/backup
set directory=~/.vim/swap
set viminfo="NONE"

if $TMUX == ''
    set clipboard=unnamed
endif

for fpath in split(globpath('~/.vim/settings', '*.vim'), '\n')
    exe 'source' fpath
endfor
