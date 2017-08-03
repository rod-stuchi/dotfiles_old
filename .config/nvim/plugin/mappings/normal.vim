" Avoid unintentional switches to Ex mode.
nnoremap Q <nop>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Like vim-vinegar.
nnoremap <silent> - :silent edit <C-R>=empty(expand('%')) ? '.' : fnameescape(expand('%:p:h'))<CR><CR>
