let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_skip_empty_sections = 1
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 0
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnametruncate = 0

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
"let g:airline_symbols.notexists = '∄'
let g:airline_symbols.notexists = ' '
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

"let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
"let g:airline_section_b = airline#section#create_left(['ffenc','hunks','%f'])
"let g:airline_section_c = airline#section#create(['filetype'])
"let g:airline_section_x = airline#section#create(['%P'])
"let g:airline_section_y = airline#section#create(['%B'])
"let g:airline_section_z = airline#section#create_right(['%l','%c'])

function! AirlineInit()
  let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
  let g:airline_section_b = airline#section#create_left(['ffenc', 'hunks', 'file'])
  let g:airline_section_c = airline#section#create(['filetype'])
  let g:airline_section_x = airline#section#create([''])
  let g:airline_section_y = airline#section#create([''])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

