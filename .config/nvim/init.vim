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
" set smartindent                    " automatically set the indent of a new line


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
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'chriskempson/base16-vim'
  " Plug 'dhruvasagar/vim-table-mode'
  " Plug 'dhruvasagar/vim-vinegar' " for nerdtree
  " Plug 'fleischie/vim-styled-components'
  " Plug 'ludovicchabant/vim-gutentags'
  " Plug 'neomake/neomake'

  Plug 'AndrewRadev/tagalong.vim'
  Plug 'Asheq/close-buffers.vim'
  Plug 'SirVer/ultisnips'
  Plug 'airblade/vim-gitgutter'
  Plug 'amadeus/vim-jsx'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'elixir-lang/vim-elixir'
  Plug 'guns/xterm-color-table.vim'
  Plug 'inkarkat/vim-ingo-library'
  Plug 'inkarkat/vim-mark'
  Plug 'joshdick/onedark.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'justinj/vim-react-snippets'
  Plug 'justinmk/vim-sneak'
  Plug 'machakann/vim-highlightedyank'
  Plug 'mattn/emmet-vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'pangloss/vim-javascript'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdtree', " { 'on': 'NERDTreeToggle' }
  Plug 'slashmili/alchemist.vim'
  Plug 'tomasr/molokai'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-surround'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'w0rp/ale'
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

" Remove diacritical signs from characters in specified range of lines.
" Examples of characters replaced: á -> a, ç -> c, Á -> A, Ç -> C.
" Uses substitute so changes can be confirmed.
function! s:RemoveDiacritics(line1, line2)
  let diacs = 'áâãàçéêíóôõüú'  " lowercase diacritical signs
  let repls = 'aaaaceeiooouu'  " corresponding replacements
  let diacs .= toupper(diacs)
  let repls .= toupper(repls)
  let diaclist = split(diacs, '\zs')
  let repllist = split(repls, '\zs')
  let trans = {}
  for i in range(len(diaclist))
    let trans[diaclist[i]] = repllist[i]
  endfor
  execute a:line1.','.a:line2 . 's/['.diacs.']/\=trans[submatch(0)]/gIce'
endfunction
command! -range=% RemoveDiacritics call s:RemoveDiacritics(<line1>, <line2>)
