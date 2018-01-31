scriptencoding utf-8

" expression to fold '#' comments and empty lines
" http://vim.1045645.n5.nabble.com/Hide-comments-td1175338.html
" http://www.rtfm-sarl.ch/articles/hide-comments.html
" https://vi.stackexchange.com/questions/3512/how-to-fold-comments
function! rods#funcs#foldconfigs ()
  " set foldexpr=getline(v:lnum)=~'^\\s*#'?1:getline(prevnonblank(v:lnum))=~'^\\s*#'?1:getline(nextnonblank(v:lnum))=~'^\\s*#'?1:0
  " set foldexpr=getline(v:lnum)=~'^\\s*\"'?1:getline(prevnonblank(v:lnum))=~'^\\s*\"'?1:getline(nextnonblank(v:lnum))=~'^\\s*\"'?1:0
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

