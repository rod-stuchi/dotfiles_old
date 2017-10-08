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
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-scripts/Mark--Karkat'
  call plug#end()

"-------------------------FUNCTIONS-----------------------
"---------------------------------------------------------
  set statusline+=%{gutentags#statusline()}
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
  nmap     <F8>       :TagbarToggle<CR>
  "nnoremap j       jzz
  "nnoremap k       kzz
