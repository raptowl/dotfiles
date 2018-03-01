"noremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR> " ESCキー2度押しでハイライトの切り替え
scriptencoding utf-8 " Vimscript内でマルチバイト文字を使う場合の設定
"source $VIMRUNTIME/macros/matchit.vim " Vimの%を拡張する(同梱プラグイン)
set ambiwidth=double " 一部文字の崩れの問題を解決
set autoread " 外部でファイルに変更がされた場合は読み直す
"set cursorline " カーソルラインをハイライト
set encoding=utf-8 " ファイル読み込み時の文字コードの設定
set expandtab " タブ入力を複数の空白入力に置き換える
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=utf-8,ucs-boms,euc-jp,cp932 " 読み込み時の文字コードの自動判別。左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別。左側が優先される
set mouse=a " マウスを有効化
set nobackup " ファイル保存時にバックアップファイルを生成しない
set noswapfile " ファイル編集中にスワップファイルを生成しない
set viminfo= " viminfoファイルを生成しない
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅
set incsearch " インクリメンタルサーチ。一文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト
set number " 行番号を表示
set backspace=start,eol,indent " バックスペースキーの有効化
set showmatch " カッコの対応関係を一瞬表示する
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数
set nocompatible " vi互換モードを切る
set cmdheight=2 " コマンドラインの行数
set laststatus=2 " ステータスラインの表示
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] " ステータスラインに表示する内容
set helpheight=999 " ヘルプを画面いっぱいに比較
set confirm " 保存されていないファイルがあるときは終了前に保存確認
set wrapscan " 最後尾まで検索を終えたら次の検索で先頭に移る
set shellslash " Windowsでもパスの区切り文字を/にする
set wildmenu wildmode=list:longest,full " コマンドラインモードでTabキーによるファイル名補完を有効にする
set noerrorbells " エラーメッセージ表示時にビープ音を鳴らさない
syntax on " シンタックスハイライト

