let g:neomake_open_list=2
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'
autocmd! BufEnter,BufWritePost *.js Neomake
