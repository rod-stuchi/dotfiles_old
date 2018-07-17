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

noremap  <F9>       :call rods#funcs#ToggleMouse()<CR>

" no more shit in command mode
nnoremap ; :
nnoremap : ;

" https://vi.stackexchange.com/a/537
" Undo only window
nnoremap <C-w>o :mksession! ~/session.vim<CR>:wincmd o<CR>
nnoremap <C-w>u :source ~/session.vim<CR>

map : <Plug>Sneak_;
map <space> <Plug>Sneak_,

