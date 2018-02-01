" ================================ general configs =================================

syntax on                        " enable syntax highlighting
set hidden                       " better buffer handling
set mouse=a                      " enable mouse
set history=2000                 " store more commands
set novisualbell                 " no borring sound
set relativenumber               " number at current line
set number                       " show relative number
set showcmd                      " show incomplete moviments at bottom
set showmode                     " show current mode at bottom


" ====================================== gui =======================================
set title                        " set title on window
set termguicolors                " set nvim 24-bit color, like gui
set cursorline                   " set cursor line
set cursorcolumn                 " set cursor column line
set linespace=3                  " line space in guis
set guifont=Fira\ Code\ 12       " font with ligatures, nice in Konsole


" ===================================== search =====================================

set incsearch                    " find the next match as we typing
set hlsearch                     " highlight by default
set ignorecase                   " ignore case when search...
set smartcase                    " ... unless you type a Capital


" ====================================== text ======================================

set nowrap                            " no wrap text
set showbreak=↪                       " when wrapping is enable
set encoding=utf-8                    " set text unicode
set list                              " for invisible characters, like tab, space
set listchars=tab:›\ ,trail:∙,eol:↲   " show invisible characters
set textwidth=0                       " no limit, disable text width
set iskeyword+=-                      " makes this-is-a-word a word
set scrolloff=8                       " 8 lines away from margins


" ===================================== indent =====================================
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start   " backspace through everything in insert mode
set autoindent                   " automatically indent new lines
" set smartindent                  " automatically set the indent of a new line


" change leader to ',' because the backslash is too far away
let mapleader = ","
" Unselect the search result
map <Leader>b :noh<CR>
" Set the title of the iterm tab
set diffopt=vertical,filler
autocmd FileType git set nofoldenable
set inccommand=split
  let g:python3_host_prog="/usr/bin/python3"
  "

" =============================== folds ===============================
set fillchars=vert:┃
set fillchars+=fold:·
set foldmethod=indent
set foldlevel=3
set foldtext=wincent#settings#foldtext()


" disable some files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" save cursor/scroll position when switching between buffers
autocmd! BufWinLeave * let b:winview = winsaveview()
autocmd! BufWinEnter * if exists('b:winview') | call winrestview(b:winview) | unlet b:winview
" Makefiles require tabs
autocmd FileType make setlocal noexpandtab

"-------------------------VimPlug-------------------------
"---------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')
  " Plug 'chriskempson/base16-vim'
  Plug 'joshdick/onedark.vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'easymotion/vim-easymotion'
  Plug 'elixir-lang/vim-elixir'
  Plug 'fleischie/vim-styled-components'
  Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'justinj/vim-react-snippets'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'mattn/emmet-vim'
  Plug 'neomake/neomake'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'pangloss/vim-javascript'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdtree' ", { 'on': 'NERDTreeToggle' }
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'SirVer/ultisnips'
  Plug 'slashmili/alchemist.vim'
  Plug 'tomasr/molokai'
  Plug 'tpope/vim-fugitive'
  Plug 'guns/xterm-color-table.vim'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-scripts/Mark--Karkat'
call plug#end()

" ============================== themes ==============================
  let g:onedark_terminal_italics = 1
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  colorscheme onedark

"-------------------------FUNCTIONS-----------------------
"---------------------------------------------------------

  nnoremap <silent> <Leader>t :Windows<CR>
  nnoremap <silent> <Leader><Space> :Buffers<CR>

autocmd FileType vim,zsh,bash silent! call rods#funcs#foldconfigs()
autocmd FileType javascript,elixir call rods#funcs#linewidth()

"-------------------------REMAP KEYS----------------------
"---------------------------------------------------------
  imap     <c-x><c-j> <plug>(fzf-complete-file-ag)
  map      <leader>n  <Plug>MarkClear
  nmap     <F9>       :call rods#funcs#ToggleMouse()<CR>
  "Remove all trailing whitespace by pressing F5
  "nnoremap j       jzz
  "nnoremap k       kzz

