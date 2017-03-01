compiler ruby
setlocal makeprg=ruby\ -wc\ %

" run currently open test
map ,t :w\|:silent !echo "rspec --color %" > test-commands<cr>:redraw!<cr>
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
