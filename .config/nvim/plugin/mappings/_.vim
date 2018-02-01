" <Leader>r -- Cycle through relativenumber + number, number (only), and no
" numbering (mnemonic: relative).
nnoremap <silent> _r :call wincent#settings#cycle_numbering()<CR>

nnoremap <silent> _M :call rods#funcs#fold_javascript_comments()<CR>
