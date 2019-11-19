#!/bin/sh

# initializing
set -u
umask 0022

# set variables
path_dotfiles="$HOME/.dotfiles"  # the path which indicates the dotfiles directory
url_gitrepo='https://github.com/raptowl/dotfiles.git'  # the url which indicates the git repository on github
url_tarball='github.com/raptowl/dotfiles/archive/master.tar.gz'  # the url which indicates the tar archive of this repository

# main routine
cd "$HOME" || exit 1
if type git > /dev/null 2>&1; then
	git clone "$url_gitrepo" "$path_dotfiles"
elif type curl > /dev/null 2>&1; then
	curl -L "$url_tarball" | tar xzv
	mv -fv "$HOME/dotfiles-master" "$path_dotfiles"
elif type wget > /dev/null 2>&1; then
	wget -O - "$url_tarball" | tar xzv
	mv -fv "$HOME/dotfiles-master" "$path_dotfiles"
else
	printf 'ERROR: command git wget or curl not found.\n' >&2
	exit 1
fi

# 1. リポジトリのダウンロード
# 2. .dotfilesディレクトリをカレントディレクトリ配下に配置（pwd=/home/katsumiなら/home/katsumi/.dotfilesとなる）
# 3. DOTFILES_LOCの値を設定してエクスポート
# 4. etc/dotlocをコピーして、3.でエクスポートした内容と同じに書き換えて$HOMEに置く
# 5. その他のドットファイルをリンク
