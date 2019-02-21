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

noremap  <F5>            :r! date +\%Y-\%m-\%d<CR>

" Insert date pt_BR
" DD/MMM (DDD)
noremap  <silent> <F6>   :lang pt_BR.UTF-8<CR>:let @@=strftime('%d/%b (%a)')<CR>:normal! p<esc>o<esc>:lang en_US.UTF-8<CR>

" Critical daily format (pt_BR):
" DD/MMM (DDD)
" ```
"   - [ ]
" ```
noremap  <silent> <F7>   :lang pt_BR.UTF-8<CR>:let @@=strftime('%d/%b (%a)')<CR>:normal! p<esc>o```  - [ ] <BS>```<esc>k$:lang en_US.UTF-8<CR>
noremap  <F9>            :call rods#funcs#ToggleMouse()<CR>

" no more shit in command mode
nnoremap ; :
nnoremap : ;

" https://vi.stackexchange.com/a/537
" Undo only window
nnoremap <C-w>o :mksession! ~/session.vim<CR>:wincmd o<CR>
nnoremap <C-w>u :source ~/session.vim<CR>

map : <Plug>Sneak_;
map <space> <Plug>Sneak_,

