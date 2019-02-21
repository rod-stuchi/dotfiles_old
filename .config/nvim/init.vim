" ================================ general configs =================================

syntax on                            " enable syntax highlighting
set hidden                           " better buffer handling
set mouse=a                          " enable mouse
set history=2000                     " store more commands
set novisualbell                     " no borring sound
set relativenumber                   " number at current line
set number                           " show relative number
set showcmd                          " show incomplete moviments at bottom
set showmode                         " show current mode at bottom
set inccommand=split                 " see changes in substitutes command
" req for nvim, in checkhealth
if has('unix')
  if has('mac')
    " mac OS
    let g:python_host_prog="/usr/local/bin/python"
    let g:python3_host_prog="/usr/local/bin/python3"
  el" se
    " linux
    let g:python_host_prog="/usr/bin/python2"
    let g:python3_host_prog="/usr/bin/python"
  endif
endif

" ====================================== gui =======================================
set title                            " set title on window
set termguicolors                    " set nvim 24-bit color, like gui
set cursorline                       " set cursor line
set cursorcolumn                     " set cursor column line
set linespace=3                      " line space in guis
set guifont=Fira\ Code\ 12           " font with ligatures, nice in Konsole


" ===================================== search =====================================

set incsearch                        " find the next match as we typing
set hlsearch                         " highlight by default
set ignorecase                       " ignore case when search...
set smartcase                        " ... unless you type a Capital
set foldopen-=search                 " don't open fold text when searching


" ====================================== text ======================================

set nowrap                           " no wrap text
set showbreak=↪                      " when wrapping is enable
set encoding=utf-8                   " set text unicode
set list                             " for invisible characters, like tab, space
" show invisible characters
set listchars=tab:›\ ,trail:∙,eol:↲,nbsp:␣
set textwidth=0                      " no limit, disable text width
set iskeyword+=-                     " makes this-is-a-word a word
set scrolloff=8                      " 8 lines away from margins
" Wrap soft breaks, break in words
com! -nargs=* Wrap set wrap linebreak nolist


" ===================================== indent =====================================
" autocmd FileType javascript,css,html setlocal ts=2 sts=2 sw=2 expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start       " backspace through everything in insert mode
set autoindent                       " automatically indent new lines
" set smartindent                      " automatically set the indent of a new line


" change leader to ',' because the backslash is too far away
let mapleader = ","
" Set the title of the iterm tab
set diffopt=vertical,filler

" ====================================== folds =====================================
set fillchars=vert:┃
set fillchars+=fold:·
set foldmethod=indent
set foldlevel=3
set foldtext=wincent#settings#foldtext()


" disable some files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz


" ===================================== vim-plug ===================================
call plug#begin('~/.local/share/nvim/plugged')
  " Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
  " Plug 'chriskempson/base16-vim'
  " Plug 'dhruvasagar/vim-table-mode'
  " Plug 'dhruvasagar/vim-vinegar' " for nerdtree
  " Plug 'fleischie/vim-styled-components'

  Plug 'Asheq/close-buffers.vim'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'SirVer/ultisnips'
  Plug 'airblade/vim-gitgutter'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'elixir-lang/vim-elixir'
  Plug 'guns/xterm-color-table.vim'
  Plug 'joshdick/onedark.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'justinj/vim-react-snippets'
  Plug 'justinmk/vim-sneak'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'mattn/emmet-vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'mxw/vim-jsx'
  Plug 'neomake/neomake'
  Plug 'pangloss/vim-javascript'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdtree' ", { 'on': 'NERDTreeToggle' }
  Plug 'slashmili/alchemist.vim'
  Plug 'tomasr/molokai'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-scripts/Mark--Karkat'
call plug#end()


" ====================================== themes ====================================
let g:onedark_terminal_italics = 1
highlight Normal ctermbg=none
highlight NonText ctermbg=none
colorscheme onedark


" ===================================== autocmds ===================================
autocmd FileType vim,zsh,bash silent! call rods#funcs#fold_comments()
autocmd FileType javascript,elixir call rods#funcs#linewidth2()
autocmd FileType * call rods#funcs#highlights()
autocmd FileType git set nofoldenable

" save cursor/scroll position when switching between buffers
autocmd! BufWinLeave * let b:winview = winsaveview()
autocmd! BufWinEnter * if exists('b:winview') | call winrestview(b:winview) | unlet b:winview
" Makefiles require tabs
autocmd FileType make setlocal noexpandtab

" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
"     \ 'javascript': ['javascript-typescript-stdio'],
"     \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
"     \ 'python': ['pyls'],
"     \ }

" :LanguageClientStart "to start using

" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" " Or map each action separately
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

