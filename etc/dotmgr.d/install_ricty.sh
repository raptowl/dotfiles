#!/bin/sh

set -u

path_tmproot="$HOME/tmp$$"
url_script="www.rs.tus.ac.jp/yyusa/ricty/ricty_generator.sh"
url_inconsolata_r="https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Regular.ttf"
url_inconsolata_b="https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Bold.ttf"
url_migu="https://ja.osdn.jp/projects/mix-mplus-ipa/downloads/63545/migu-1m-20150712.zip"
url_fontforge="https://sourceforge.net/projects/fontforge/files/fontforge-source/fontforge_full-20120731-b.tar.bz2/download"

trap '
    if [ -d "$path_tmproot" ]
    then
        rm -rf "$path_tmproot"
    fi
    if [ -d "$HOME/.FontForge" ]
    then
        rm -rf "$HOME/.FontForge"
    fi
' 1 2 3 15

if ! command -v unzip > /dev/null 2>&1
then
    printf "ERROR: command \"unzip\" not found.\\n" 1>&2
    exit 1
fi

mkdir \
    "$path_tmproot" \
    "$path_tmproot/sourcefiles" \
    "$path_tmproot/fontforge"
cd "$path_tmproot" || exit

if command -v wget > /dev/null 2>&1
then
    wget -O - "$url_script" > "$path_tmproot/sourcefiles/ricty_generator.sh" &&
    wget -O - "$url_inconsolata_r" > "$path_tmproot/sourcefiles/Inconsolata-Regular.ttf" &&
    wget -O - "$url_inconsolata_b" > "$path_tmproot/sourcefiles/Inconsolata-Bold.ttf" &&
    wget -O - "$url_migu" > "$path_tmproot/migu-1m-20150712.zip" &&
    unzip "$path_tmproot/migu-1m-20150712.zip" &&
    mv -fv "$path_tmproot/migu-1m-20150712/migu-1m-regular.ttf" "$path_tmproot/sourcefiles" &&
    mv -fv "$path_tmproot/migu-1m-20150712/migu-1m-bold.ttf" "$path_tmproot/sourcefiles" &&
    if command -v fontforge > /dev/null 2>&1
    then
        cd "$path_tmproot/sourcefiles" || exit
        sh ricty_generator.sh auto
    else
        wget -O - "$url_fontforge" | tar xjv &&
        cd "$path_tmproot/fontforge-20120731-b" || exit
        ./configure --prefix="$path_tmproot/fontforge" && make && make install &&
        cd "$path_tmproot/sourcefiles" || exit
        PATH="$path_tmproot/fontforge/bin:$PATH" sh ricty_generator.sh auto
    fi &&
    if [ ! -d "$HOME/.fonts" ]
    then
        mkdir "$HOME/.fonts"
    fi &&
    mv -fv "$path_tmproot/sourcefiles/Ricty*.ttf" "$HOME/.fonts" &&
    cd "$path_tmproot" || exit
elif command -v curl > /dev/null 2>&1
then
    curl -L "$url_script" > "$path_tmproot/sourcefiles/ricty_generator.sh" &&
    curl -L "$url_inconsolata_r" > "$path_tmproot/sourcefiles/Inconsolata-Regular.ttf" &&
    curl -L "$url_inconsolata_b" > "$path_tmproot/sourcefiles/Inconsolata-Bold.ttf" &&
    curl -L "$url_migu" > "$path_tmproot/migu-1m-20150712.zip" &&
    unzip "$path_tmproot/migu-1m-20150712.zip" &&
    mv -fv "$path_tmproot/migu-1m-20150712/migu-1m-regular.ttf" "$path_tmproot/sourcefiles" &&
    mv -fv "$path_tmproot/migu-1m-20150712/migu-1m-bold.ttf" "$path_tmproot/sourcefiles" &&
    if command -v fontforge > /dev/null 2>&1
    then
        cd "$path_tmproot/sourcefiles" || exit
        sh ricty_generator.sh auto
    else
        curl -L "$url_fontforge" | tar xjv &&
        cd "$path_tmproot/fontforge-20120731-b" || exit
        ./configure --prefix="$path_tmproot/fontforge" && make && make install &&
        cd "$path_tmproot/sourcefiles" || exit
        PATH="$path_tmproot/fontforge/bin:$PATH" sh ricty_generator.sh auto
    fi &&
    if [ ! -d "$HOME/.fonts" ]
    then
        mkdir "$HOME/.fonts"
    fi &&
    mv -fv "$path_tmproot/sourcefiles/Ricty*.ttf" "$HOME/.fonts" &&
    cd "$path_tmproot" || exit
else
    printf "ERROR: command \"wget\" or \"curl\" not found.\\n" 1>&2
    exit 1
fi

if [ -d "$path_tmproot" ]
then
    rm -rf "$path_tmproot"
fi
if [ -d "$HOME/.FontForge" ]
then
    rm -rf "$HOME/.FontForge"
fi

