"CtrlP: Full path fuzzy finder Borrowed from @skwp
"if executable('ag')
"  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"  let g:ctrlp_user_command =
"        \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$|node_modules|docs$"'
"
"  " ag is fast enough that CtrlP doesn't need to cache
"  let g:ctrlp_use_caching = 0
"  let g:ctrlp_match_window = 'min:4,max:24'
"else
"  " Fall back to using git ls-files if Ag is not available
"  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|node_modules|docs$'
"  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
"endif

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

let g:ctrlp_match_window = 'min:4,max:24'

let g:ctrlp_arg_map = 0

let g:ctrlp_open_multiple_files = '1vjr'
