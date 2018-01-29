" Avoid unintentional switches to Ex mode.
nnoremap Q <nop>

noremap  <Up>       <Nop>
noremap  <Down>     <Nop>
noremap  <Left>     <Nop>
noremap  <Right>    <Nop>

" navigate between splited window
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


nnoremap <F5>       :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
nnoremap <leader>zz :call rods#funcs#VCenterCursor()<CR>
