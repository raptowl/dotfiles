" general
scriptencoding utf-8
set ambiwidth=double
set autoread
set backspace=start,eol,indent
set clipboard=unnamed,autoselect
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
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set viminfo=
set wildmenu
set wildmenu wildmode=list:longest,full
set wrapscan
let g:netrw_dirhistmax=0

" indent
if has("autocmd")
	filetype plugin on
	filetype indent on
	autocmd FileType c setlocal cindent smarttab noexpandtab tabstop=4 softtabstop=0 shiftwidth=4
	autocmd FileType haskell setlocal autoindent smarttab expandtab tabstop=4 softtabstop=0 shiftwidth=4
	autocmd FileType make setlocal autoindent smarttab noexpandtab tabstop=4 softtabstop=0 shiftwidth=4
	autocmd FileType sh setlocal autoindent smarttab noexpandtab tabstop=4 softtabstop=0 shiftwidth=4
	autocmd FileType text setlocal autoindent smarttab noexpandtab tabstop=4 softtabstop=0 shiftwidth=4
	autocmd FileType vim setlocal autoindent smarttab noexpandtab tabstop=4 softtabstop=0 shiftwidth=4
endif

" colors
syntax on
colorscheme default
