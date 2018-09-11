scriptencoding utf-8
set ambiwidth=double
set autoread
set backspace=start,eol,indent
set cmdheight=2
set confirm
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-boms,euc-jp,cp932
set fileformats=unix,dos,mac
set helpheight=999
set history=5000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set mouse=a
set nobackup
set nocompatible
set noerrorbells
set noswapfile
set number
set ruler
set shellslash
set showcmd
set showmatch
set smartcase
set smartindent
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set viminfo=
set wildmenu
set wildmenu wildmode=list:longest,full
set wrapscan
let g:netrw_dirhistmax=0

filetype plugin indent on
set noexpandtab
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

syntax on
colorscheme default
autocmd ColorScheme * highlight Comment ctermfg=darkgray

