" <Leader>r -- Cycle through relativenumber + number, number (only), and no
" numbering (mnemonic: relative).
nnoremap <silent> _C :call wincent#settings#cycle_numbering()<CR>

nnoremap <silent> _M :call rods#funcs#fold_comments()<CR>

" Delete trailing whitespace
nnoremap <unique> <silent> _$ :call rods#funcs#preserve("%s/\\s\\+$//e")<cr>

" Reindent entire file
nnoremap <unique> <silent> _i :call rods#funcs#preserve("normal! gg=G")<cr>

