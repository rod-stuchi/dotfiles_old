scriptencoding utf-8

" expression to fold '#' comments and empty lines
" http://vim.1045645.n5.nabble.com/Hide-comments-td1175338.html
" http://www.rtfm-sarl.ch/articles/hide-comments.html
" https://vi.stackexchange.com/questions/3512/how-to-fold-comments
function! rods#funcs#foldconfigs ()
  " thanks to crisbra10
  " https://www.reddit.com/r/vim/comments/7u7lqu/how_foldexpr_regex_with_multi_matches/dtidk57/
  let &foldexpr='getline(v:lnum)=~''^\s*#\|^\s*"\|^\s*//\|^\s*$'''
  set foldmethod=expr foldexpr foldlevel=0
endfunction


function! rods#funcs#linewidth ()
  set colorcolumn=100
  highlight ColorColumn ctermbg=52 guibg=#28342a
  " highlight before 100 characters
  " https://stackoverflow.com/a/235970/6785523
  highlight OverLength ctermbg=52 guibg=#28342a
  match OverLength /\%101v.\+/
endfunction


function! rods#funcs#ToggleMouse()
  " check if mouse is enabled
  if &mouse == 'a'
    " disable mouse
    set mouse=
  else
    " enable mouse everywhere
    set mouse=a
  endif
endfunction


if !exists('*VCenterCursor')
  augroup VCenterCursor
  au!
  au OptionSet *,*.*
    \ if and( expand("<amatch>")=='scrolloff' ,
    \         exists('#VCenterCursor#WinEnter,WinNew,VimResized') )|
    \   au! VCenterCursor WinEnter,WinNew,VimResized|
    \ endif
  augroup END
  function rods#funcs#VCenterCursor()
    if !exists('#VCenterCursor#WinEnter,WinNew,VimResized')
      let s:default_scrolloff=&scrolloff
      let &scrolloff=winheight(win_getid())/2
      au VCenterCursor WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/2
    else
      au! VCenterCursor WinEnter,WinNew,VimResized
      let &scrolloff=s:default_scrolloff
    endif
  endfunction
endif


function! rods#funcs#fold_javascript_comments () abort
  let &foldexpr='getline(v:lnum)=~''^\s*\*\|^\s*//\|^\s*$'''
  setlocal foldmethod=expr foldexpr foldlevel=0
  " autocmd FileType javascript silent! setlocal foldmethod=indent "expr foldexpr foldlevel=0
endfunction


" from vimcast comment "dougireton" http://disq.us/p/hircqe
function! rods#funcs#preserve(command)
  " Preparation: save last search, and cursor position.
  let l:win_view = winsaveview()
  let l:last_search = getreg('/')

  " execute the command without adding to the changelist/jumplist:
  execute 'keepjumps ' . a:command

  " Clean up: restore previous search history, and cursor position
  call winrestview(l:win_view)
  call setreg('/', l:last_search)
endfunction

