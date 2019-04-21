#!/bin/sh

set -u
umask 0022

# path to the temporary directory
path_tmproot="$HOME/tmp$$"

# path to install fonts
path_fonts_to_set="$HOME/.local/share/fonts"

# url of ricty generation script
url_script='www.rs.tus.ac.jp/yyusa/ricty/ricty_generator.sh'

# url of font 'inconsolata regular'
url_inconsolata_r='github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Regular.ttf'

# url of font 'inconsolata bold'
url_inconsolata_b='github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Bold.ttf'

# url of font 'migu'
url_migu='ja.osdn.jp/projects/mix-mplus-ipa/downloads/63545/migu-1m-20150712.zip'

# url of fontforge
url_fontforge='sourceforge.net/projects/fontforge/files/fontforge-source/fontforge_full-20120731-b.tar.bz2/download'

# remove tmporary directory
remove_tmproot() {
	[ -d "$path_tmproot" ] && rm -rf "$path_tmproot"
	[ -d "$HOME/.FontForge" ] && rm -rf "$HOME/.FontForge"
}
trap 'remove_tmproot' 1 2 3 15

# output error and exit if command 'make' is not installed
if ! type make >/dev/null 2>&1; then
	printf 'ERROR: command make not found.\n' >&2
	exit 1
fi

# output error and exit if command 'gcc' is not installed
if ! type gcc >/dev/null 2>&1; then
	printf 'ERROR: command gcc not found.\n' >&2
	exit 1
fi

# output error and exit if command 'unzip' is not installed
if ! type unzip >/dev/null 2>&1; then
	printf 'ERROR: command unzip not found.\n' >&2
	exit 1
fi

# make a directory to install fonts
[ ! -d "$path_fonts_to_set" ] && mkdir -p "$path_fonts_to_set"

# make temporary directories
mkdir -p "$path_tmproot"
mkdir -p "$path_tmproot/sourcefiles"
mkdir -p "$path_tmproot/fontforge"

# main routine
cd "$path_tmproot" || exit 1
if type curl >/dev/null 2>&1; then
	# download the ricty generation script
	curl -L "$url_script" >'./sourcefiles/ricty_generator.sh'

	# download fonts 'Inconsolata-Regular' and 'Inconsolata-Bold'
	curl -L "$url_inconsolata_r" >'./sourcefiles/Inconsolata-Regular.ttf'
	curl -L "$url_inconsolata_b" >'./sourcefiles/Inconsolata-Bold.ttf'

	# download fonts 'Migu-1m' series
	curl -L "$url_migu" >'./migu-1m-20150712.zip'
	unzip "$path_tmproot/migu-1m-20150712.zip"
	mv -fv './migu-1m-20150712/migu-1m-regular.ttf' './sourcefiles'
	mv -fv './migu-1m-20150712/migu-1m-bold.ttf' './sourcefiles'

	# if 'FontForge' is not installed in the system, make its binary locally and run the ricty generation script
	if ! type fontforge >/dev/null 2>&1; then
		curl -L "$url_fontforge" | tar xjv
		cd "$path_tmproot/fontforge-20120731-b" || exit
		./configure --prefix="$path_tmproot/fontforge" && make && make install
		cd "$path_tmproot/sourcefiles" || exit
		PATH="$path_tmproot/fontforge/bin:$PATH" sh ricty_generator.sh auto
	else
		cd "$path_tmproot/sourcefiles" || exit
		sh ricty_generator.sh auto
	fi
elif type wget >/dev/null 2>&1; then
	# download the ricty generation script
	wget -O - "$url_script" >'./sourcefiles/ricty_generator.sh'

	# download fonts 'Inconsolata-Regular' and 'Inconsolata-Bold'
	wget -O - "$url_inconsolata_r" >'./sourcefiles/Inconsolata-Regular.ttf'
	wget -O - "$url_inconsolata_b" >'./sourcefiles/Inconsolata-Bold.ttf'

	# download fonts 'Migu-1m' series
	wget -O - "$url_migu" >'./migu-1m-20150712.zip'
	unzip "$path_tmproot/migu-1m-20150712.zip"
	mv -fv './migu-1m-20150712/migu-1m-regular.ttf' './sourcefiles'
	mv -fv './migu-1m-20150712/migu-1m-bold.ttf' './sourcefiles'

	# if 'FontForge' is not installed in the system, make its binary locally and run the ricty generation script
	if ! type fontforge >/dev/null 2>&1; then
		wget -O - "$url_fontforge" | tar xjv
		cd "$path_tmproot/fontforge-20120731-b" || exit
		./configure --prefix="$path_tmproot/fontforge" && make && make install
		cd "$path_tmproot/sourcefiles" || exit
		PATH="$path_tmproot/fontforge/bin:$PATH" sh ricty_generator.sh auto
	else
		cd "$path_tmproot/sourcefiles" || exit
		sh ricty_generator.sh auto
	fi
else
	printf 'ERROR: command wget or curl not found.\n' >&2
	exit 1
fi

# remove tmporary directory
remove_tmproot
