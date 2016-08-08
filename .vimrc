if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'tpope/vim-sensible'
NeoBundle 'tpope/vim-eunuch'
"NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'tomtom/tcomment_vim'
"NeoBundle 'scrooloose/syntastic'
NeoBundle 'airblade/vim-gitgutter'
"NeoBundle 'chase/vim-ansible-yaml'
"NeoBundle 'tejr/vim-nagios'
NeoBundle 'saltstack/salt-vim'
NeoBundle 'robbles/logstash.vim'
"NeoBundle 'Glench/Vim-Jinja2-Syntax'
"NeoBundle 'solarnz/thrift.vim'
"NeoBundle 'Matt-Deacalion/vim-systemd-syntax'
"NeoBundle 'othree/html5.vim'
"NeoBundle 'Keithbsmiley/swift.vim'
"NeoBundle 'derekwyatt/vim-scala'
"NeoBundle 'davidhalter/jedi-vim'
"NeoBundle 'junegunn/vader.vim'
"NeoBundleLazy 'docker/docker', {'rtp': 'contrib/syntax/vim/', 'autoload': {'filetypes' : ['dockerfile']}}
"NeoBundleLazy 'icinga/icinga2', {'rtp': 'tools/syntax/vim/'}
"NeoBundleLazy 'mfukar/robotframework-vim', {'autoload': {'filetypes' : ['robot']}}
"NeoBundleLazy 'pangloss/vim-javascript', {'autoload': {'filetypes' : ['javascript']}}
NeoBundleLazy 'nginx/nginx', {'rtp': 'contrib/vim/', 'autoload': {'filetypes' : ['nginx']}}

"let s:php_plugins = ['StanAngeloff/php.vim', 'joonty/vim-phpqa', '2072/PHP-Indenting-for-VIm']
"for g:plugin in s:php_plugins
"    NeoBundleLazy g:plugin, {'autoload' : { 'filetypes' : ['php'] }}
"endfor
"unlet s:php_plugins

"let s:ruby_plugins = ['vim-ruby/vim-ruby', 'thoughtbot/vim-rspec']
"for g:plugin in s:ruby_plugins
"    NeoBundleLazy g:plugin, {'autoload' : { 'filetypes' : ['ruby'] }}
"endfor
"unlet s:ruby_plugins

"let s:python_plugins = ['klen/python-mode', 'nvie/vim-flake8']
"for g:plugin in s:python_plugins
"    NeoBundleLazy g:plugin, {'autoload' : { 'filetypes' : ['python'] }}
"endfor
"unlet s:python_plugins

"let s:erlang_plugins = ['edkolev/erlang-motions.vim', 'jimenezrick/vimerl']
"for g:plugin in s:erlang_plugins
"    NeoBundleLazy g:plugin, {'autoload' : { 'filetypes' : ['erlang'] }}
"endfor
"unlet s:erlang_plugins

"unlet g:plugin

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

set number
syntax enable
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set vb t_vb=
cabbrev W w
cabbrev Q q
let mapleader=","
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set viminfo="NONE"
set mouse=
set nofoldenable

for fpath in split(globpath('~/.vim/settings', '*.vim'), '\n')
    exe 'source' fpath
endfor
