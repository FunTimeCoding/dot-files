if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'airblade/vim-gitgutter'
"NeoBundle 'scrooloose/syntastic'
"NeoBundle 'chase/vim-ansible-yaml'
"NeoBundle 'othree/html5.vim'
"NeoBundle 'Keithbsmiley/swift.vim'
"NeoBundle 'derekwyatt/vim-scala'
"NeoBundle 'davidhalter/jedi-vim'
"NeoBundle 'junegunn/vader.vim'
"NeoBundleLazy 'pangloss/vim-javascript', {'autoload': {'filetypes' : ['javascript']}}

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
"set vb t_vb=
cabbrev W w
cabbrev Q q
"let mapleader=','
set backupdir=~/.vim/backup
set directory=~/.vim/swap
"set viminfo="NONE"
"set mouse=
"set nofoldenable

for fpath in split(globpath('~/.vim/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor
