compiler ruby
setlocal makeprg=ruby\ -wc\ %

" run currently open test
map ,t :w\|:silent !echo "rspec --color %" > test-commands<cr>:redraw!<cr>
