" open Windows fzf
nnoremap <silent> <Leader>w :Windows<CR>
" open Buffers fzf
nnoremap <silent> <Leader><Space> :Buffers<CR>

" yank in clipboard file name
nnoremap <silent> <Leader>yn :let @*=expand("%")<CR>
" yank in clipboard file path
nnoremap <silent> <Leader>yp :let @*=expand("%:p")<CR>

" edit command, files in same folder, from vimcast/e/14
map <leader>ew ;e %%
map <leader>es ;sp %%
map <leader>ev ;vsp %%
map <leader>et ;tabe %%

" remap :MarkClear to leader n
autocmd VimEnter * noremap <leader>n :MarkClear<cr>

nnoremap <leader>zz :call rods#funcs#VCenterCursor()<CR>

" open fzf in same folder, grabbed from issues fzf.vim
autocmd VimEnter * nnoremap <silent> <Leader><Leader> :Files <CR>
autocmd VimEnter * nnoremap <silent> <Leader>d :Files <C-R>=expand('%:h')<CR><CR>

nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>

nnoremap <silent> <Leader>t :call fzf#vim#tags(expand('<cword>'))<CR>

nnoremap <silent> <Leader>s :call fzf#vim#snippets()<CR>
nnoremap <silent> <Leader>k :call fzf#vim#marks()<CR>

" Unselect the search
" map <enter> ;noh<CR>
nnoremap <leader>c :noh<CR>

