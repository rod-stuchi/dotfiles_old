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

" edit command, files in same folder, from vimcast/e/14
map <leader>ew ;e %%
map <leader>es ;sp %%
map <leader>ev ;vsp %%
map <leader>et ;tabe %%

" use _$ instead
" nnoremap <F5>       :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
"
noremap  <F9>       :call rods#funcs#ToggleMouse()<CR>
nnoremap <leader>zz :call rods#funcs#VCenterCursor()<CR>

" no more shit in command mode
nnoremap ; :
nnoremap : ;

" Unselect the search
" map <enter> ;noh<CR>
nnoremap <CR> :noh<CR>

" https://vi.stackexchange.com/a/537
" Undo only window
nnoremap <C-w>o :mksession! ~/session.vim<CR>:wincmd o<CR>
nnoremap <C-w>u :source ~/session.vim<CR>

map : <Plug>Sneak_;
map <space> <Plug>Sneak_,

