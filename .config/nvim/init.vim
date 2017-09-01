" Activate Syntax Highlight
  syntax enable
" set default encoding to UTF-8
  set encoding=utf-8 

" Highlight search results
  set hlsearch
" Incremental search, search as you type
  set incsearch
" Ignore case when searching
  set ignorecase smartcase
" Ignore case when searching lowercase
  set smartcase

" Deactivate Wrapping
  set nowrap
  set showbreak=↪

" Treat all numbers as decimal
  " set nrformats=
" I don't like Swapfiles
  " set noswapfile
" Don't make a backup before overwriting a file.
  " set nobackup
" And again.
  " set nowritebackup
" I prefer , to be the leader key
  let mapleader = ","
" show line numbers
  set relativenumber number
" MOAR colors
  set t_Co=256
" Unselect the search result
  map <Leader><Space> :noh<CR>
" Better buffer handling
  set hidden
" hightlight cursor position
  set cursorline cursorcolumn
" set font compatible with arline
  set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11 
  "set guifont=Source\ Code\ Pro\ for\ Powerline

" enable mouse
  set mouse=a

" Set the title of the iterm tab
  set title

  set diffopt=vertical,filler
  autocmd FileType git set nofoldenable

  set inccommand=split

" Show invisible characters:
"   Tabs and trailing whitespace
  set list
  set listchars=tab:›\ ,trail:.

  set tabstop=2
" Soft-Tabs should be 2 spaces
  set softtabstop=2
" When shifting, use 2 spaces
  set shiftwidth=2
" Use Soft-Tabs
  set expandtab
" backspace through everything in insert mode
  set backspace=indent,eol,start
" Automatically set the indent of a new line
  set autoindent smartindent

  set textwidth=0
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules

  set foldmethod=indent foldlevel=3
" expression to fold '#' comments and empty lines
"   http://vim.1045645.n5.nabble.com/Hide-comments-td1175338.html
  set fde=getline(v:lnum)=~'^\\s*#'?1:getline(prevnonblank(v:lnum))=~'^\\s*#'?1:getline(nextnonblank(v:lnum))=~'^\\s*#'?1:0 
" autocmd BufRead,BufNewFile   *.zshrc setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\s*#'
"   https://vi.stackexchange.com/questions/3512/how-to-fold-comments
  autocmd BufRead,BufNewFile *.zshrc,*.conf setlocal foldmethod=expr fde foldlevel=0
" Makefiles require tabs
  autocmd FileType make setlocal noexpandtab

"-------------------------VimPlug-------------------------
"---------------------------------------------------------
  call plug#begin('~/.local/share/nvim/plugged')
  Plug 'chriskempson/base16-vim'

" CtrlP: Full path fuzzy finder
  Plug 'ctrlpvim/ctrlp.vim'
    " Borrowed from @skwp
    if executable('ag')
      " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
      let g:ctrlp_user_command =
        \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$|node_modules"'

      " ag is fast enough that CtrlP doesn't need to cache
      let g:ctrlp_use_caching = 0
    else
      " Fall back to using git ls-files if Ag is not available
      let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$|node_modules'
      let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
    endif
  Plug 'airblade/vim-gitgutter'
  Plug 'easymotion/vim-easymotion'
  Plug 'elixir-lang/vim-elixir'
  Plug 'fleischie/vim-styled-components'
  Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'justinj/vim-react-snippets'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'majutsushi/tagbar'
  Plug 'mattn/emmet-vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'pangloss/vim-javascript'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdtree' ", { 'on': 'NERDTreeToggle' }
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'slashmili/alchemist.vim'
  Plug 'tomasr/molokai'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-scripts/Mark--Karkat'
  Plug 'vim-syntastic/syntastic'
  call plug#end()

"-------------------------FUNCTIONS-----------------------
"---------------------------------------------------------
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_always_populate_loc_list = 1
  "let g:syntastic_auto_loc_list = 1
  "let g:syntastic_check_on_open = 0
  "let g:syntastic_check_on_wq = 0
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_javascript_eslint_exe = 'npx eslint .'


  set scrolloff=0
  if !exists('*VCenterCursor')
    augroup VCenterCursor
    au!
    au OptionSet *,*.*
      \ if and( expand("<amatch>")=='scrolloff' ,
      \         exists('#VCenterCursor#WinEnter,WinNew,VimResized') )|
      \   au! VCenterCursor WinEnter,WinNew,VimResized|
      \ endif
    augroup END
    function VCenterCursor()
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


  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_refresh_always = 1

  "Narrow ag results within vim
  function! s:ag_to_qf(line)
    let parts = split(a:line, ':')
    return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
          \ 'text': join(parts[3:], ':')}
  endfunction

  function! s:ag_handler(lines)
    if len(a:lines) < 2 | return | endif

    let cmd = get({'ctrl-x': 'split',
                 \ 'ctrl-v': 'vertical split',
                 \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
    let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

    let first = list[0]
    execute cmd escape(first.filename, ' %#\')
    execute first.lnum
    execute 'normal!' first.col.'|zz'

    if len(list) > 1
      call setqflist(list)
      copen
      wincmd p
    endif
  endfunction

  command! -nargs=* Ag call fzf#run({
  \ 'source':  printf('ag --nogroup --column --color "%s"',
  \                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
  \ 'sink*':    function('<sid>ag_handler'),
  \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
  \            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
  \            '--color hl:68,hl+:110',
  \ 'down':    '50%'
  \ })

  command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

  "Toggle Mouse
  function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        " disable mouse
        set mouse=
    else
        " enable mouse everywhere
        set mouse=a
    endif
  endfunc


  command! -nargs=* OpenTabs call fzf#run({'sink': 'tabedit', 'options': '--multi --reverse'})

  nnoremap <silent> <Leader>t :Windows<CR>
  nnoremap <silent> <Leader>b :Buffers<CR>

"-------------------------COLOR SCHEME--------------------
"---------------------------------------------------------
  syntax enable
  let base16colorspace=256
  colorscheme base16-summerfruit-dark
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none


"-------------------------REMAP KEYS----------------------
"---------------------------------------------------------
  map      <C-f>      <Plug>(easymotion-s)
  map      <C-S-f>    <Plug>(easymotion-s2)
  map      <C-n>      :NERDTreeToggle<CR>
  noremap  <Up>       <Nop>
  noremap  <Down>     <Nop>
  noremap  <Left>     <Nop>
  noremap  <Right>    <Nop>
  xmap     ga         <Plug>(EasyAlign)
  nnoremap <leader>zz :call VCenterCursor()<CR>
  imap     <c-x><c-j> <plug>(fzf-complete-file-ag)
  nmap     <F8>       :TagbarToggle<CR>
  nmap     <F9>       :call ToggleMouse()<CR>
  "Remove all trailing whitespace by pressing F5
  nnoremap <F5>       :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
  "nnoremap j       jzz
  "nnoremap k       kzz
