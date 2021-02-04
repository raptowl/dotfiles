source $VIMRUNTIME/defaults.vim  " load default settings

" general
scriptencoding utf-8  " the encoding of vimscript
set ambiwidth=double
set autoread
set backspace=start,eol,indent
set clipboard=unnamed,autoselect
set cmdheight=2
set confirm
set cursorline
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
set visualbell
set t_vb=
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
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=4
set softtabstop=0
set shiftwidth=4
if has("autocmd")
    filetype plugin on
    filetype indent on
    autocmd FileType css  setlocal expandtab   tabstop=2 softtabstop=0 shiftwidth=2
    autocmd FileType html setlocal expandtab   tabstop=2 softtabstop=0 shiftwidth=2
    autocmd FileType make setlocal noexpandtab tabstop=2 softtabstop=0 shiftwidth=2
    autocmd FileType sh   setlocal expandtab   tabstop=2 softtabstop=0 shiftwidth=2
    autocmd FileType yaml setlocal expandtab   tabstop=2 softtabstop=0 shiftwidth=2
endif

" colors
syntax on
colorscheme default
set background=dark

" Escを2回押すとハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR>

" プラグインのインストール先のパスを追加
set runtimepath+=~/usr/vim-plug/vimdoc-ja
set runtimepath+=~/usr/vim-plug/iceberg.vim
set runtimepath+=~/usr/vim-plug/nerdtree
set runtimepath+=~/usr/vim-plug/vim-lsp
set runtimepath+=~/usr/vim-plug/vim-lsp-settings
set runtimepath+=~/usr/vim-plug/asyncomplete.vim
set runtimepath+=~/usr/vim-plug/asyncomplete-lsp.vim
