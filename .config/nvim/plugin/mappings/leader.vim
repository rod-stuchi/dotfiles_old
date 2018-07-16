" open Windows fzf
nnoremap <silent> <Leader>w :Windows<CR>
" open Buffers fzf
nnoremap <silent> <Leader><Space> :Buffers<CR>

nnoremap <silent> <Leader>cn :let @*=expand("%")<CR>
nnoremap <silent> <Leader>cp :let @*=expand("%:p")<CR>

" remap :MarkClear to leader n
autocmd VimEnter * noremap <leader>n :MarkClear<cr>

" open fzf in same folder, grabbed from issues fzf.vim
autocmd VimEnter * nnoremap <silent> <Leader><Leader> :Files <CR>
autocmd VimEnter * nnoremap <silent> <Leader>d :Files <C-R>=expand('%:h')<CR><CR>

nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>

nnoremap <silent> <Leader>t :call fzf#vim#tags(expand('<cword>'))<CR>

nnoremap <silent> <Leader>s :call fzf#vim#snippets()<CR>
nnoremap <silent> <Leader>k :call fzf#vim#marks()<CR>

