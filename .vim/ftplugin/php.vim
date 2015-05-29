setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=120

" <TAB> indents according to 'shiftwidth' at beginning of line
setlocal smarttab

" <TAB> always inserts 'softtabstop' amount of space characters
setlocal expandtab

" for php.vim to wrap methods
setlocal foldlevel=99

" run currently open test
map ,t :w\|:silent !echo "vendor/bin/phpunit %" > test-commands<cr>:redraw!<cr>
