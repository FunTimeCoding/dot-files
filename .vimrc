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
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'chase/vim-ansible-yaml'
NeoBundle 'tejr/vim-nagios'
NeoBundleLazy 'docker/docker', {'rtp': 'contrib/syntax/vim/', 'autoload': {'filetypes' : ['dockerfile']}}
NeoBundleLazy 'mfukar/robotframework-vim', {'autoload': {'filetypes' : ['robot']}}

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

unlet g:plugin
" end of bundles list

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" end of neobundle setup

set number
syntax enable
