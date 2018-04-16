" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --smart-case --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* AFiles
  \ call fzf#run(fzf#wrap({'source': 'rg --files --hidden --no-ignore-vcs --glob "!.git/*" --glob "!node_modules" ', 'left': '~30%'}))

command! -nargs=* OpenTabs call fzf#run({'sink': 'tabedit', 'options': '--multi --reverse'})

nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>

nnoremap <Leader>tag :call fzf#vim#tags(expand('<cword>'))
