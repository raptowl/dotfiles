#!/bin/sh

set -u
umask 0022

# path to the temporary directory
path_tmproot="$HOME/tmp$$"

# path to install fonts
path_fonts_to_set="$HOME/.local/share/fonts"

# url of 'ricty' generation script
url_script='www.rs.tus.ac.jp/yyusa/ricty/ricty_generator.sh'

# url of font 'inconsolata regular'
url_inconsolata_r='github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Regular.ttf'

# url of font 'inconsolata bold'
url_inconsolata_b='github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Bold.ttf'

# url of font 'migu'
url_migu='ja.osdn.jp/projects/mix-mplus-ipa/downloads/63545/migu-1m-20150712.zip'

# url of 'fontforge'
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

# make a temporary root directory
[ ! -d "$path_tmproot" ] && mkdir -p "$path_tmproot"

# change the working directory to the temporary root directory, and make a source files directory and a 'fontforge' directory.
cd "$path_tmproot" || exit
[ ! -d './sourcefiles' ] && mkdir -p './sourcefiles'
[ ! -d './fontforge' ] && mkdir -p './fontforge'

if type curl >/dev/null 2>&1; then
# if command 'curl' is installed, download files using 'curl' to generate 'ricty'

	# download the 'ricty' generation script
	curl -L "$url_script" >'./sourcefiles/ricty_generator.sh'

	# download fonts 'Inconsolata-Regular' and 'Inconsolata-Bold'
	curl -L "$url_inconsolata_r" >'./sourcefiles/Inconsolata-Regular.ttf'
	curl -L "$url_inconsolata_b" >'./sourcefiles/Inconsolata-Bold.ttf'

	# download fonts 'Migu-1m' series
	curl -L "$url_migu" >'./migu-1m-20150712.zip'
	unzip './migu-1m-20150712.zip'
	mv -fv './migu-1m-20150712/migu-1m-regular.ttf' './sourcefiles'
	mv -fv './migu-1m-20150712/migu-1m-bold.ttf' './sourcefiles'

	if ! type fontforge >/dev/null 2>&1; then
	# if 'fontforge' is not installed in the system, make its binary locally and run the 'ricty' generation script

		# download source files of 'fontforge'
		curl -L "$url_fontforge" | tar xjv

		# build 'fontforge'
		cd "$path_tmproot/fontforge-20120731-b" || exit
		./configure --prefix="$path_tmproot/fontforge" && make && make install

		# run the 'ricty' generation script
		cd "$path_tmproot/sourcefiles" || exit
		PATH="$path_tmproot/fontforge/bin:$PATH" sh ricty_generator.sh auto
	else
	# if 'fontforge' is installed in the system, only run the 'ricty' generation script

		# run the 'ricty' generation script
		cd "$path_tmproot/sourcefiles" || exit
		sh ricty_generator.sh auto
	fi
elif type wget >/dev/null 2>&1; then
# if 'curl' is not installed but 'wget' is installed, download files using 'wget' to generate 'ricty'

	# download the 'ricty' generation script
	wget -O - "$url_script" >'./sourcefiles/ricty_generator.sh'

	# download fonts 'Inconsolata-Regular' and 'Inconsolata-Bold'
	wget -O - "$url_inconsolata_r" >'./sourcefiles/Inconsolata-Regular.ttf'
	wget -O - "$url_inconsolata_b" >'./sourcefiles/Inconsolata-Bold.ttf'

	# download fonts 'Migu-1m' series
	wget -O - "$url_migu" >'./migu-1m-20150712.zip'
	unzip './migu-1m-20150712.zip'
	mv -fv './migu-1m-20150712/migu-1m-regular.ttf' './sourcefiles'
	mv -fv './migu-1m-20150712/migu-1m-bold.ttf' './sourcefiles'

	if ! type fontforge >/dev/null 2>&1; then
	# if 'fontforge' is not installed in the system, make its binary locally and run the 'ricty' generation script

		# download source files of 'fontforge'
		wget -O - "$url_fontforge" | tar xjv

		# build 'fontforge'
		cd "$path_tmproot/fontforge-20120731-b" || exit
		./configure --prefix="$path_tmproot/fontforge" && make && make install

		# run the 'ricty' generation script
		cd "$path_tmproot/sourcefiles" || exit
		PATH="$path_tmproot/fontforge/bin:$PATH" sh ricty_generator.sh auto
	else
	# if 'fontforge' is installed in the system, only run the 'ricty' generation script

		# run the 'ricty' gene
		cd "$path_tmproot/sourcefiles" || exit
		sh ricty_generator.sh auto
	fi
else
# if neither 'curl' nor 'wget' are installed, output error message and exit

	printf 'ERROR: command wget or curl not found.\n' >&2
	exit 1
fi

# make a directory which indicates "$path_fonts_to_set" to install fonts, and change 
[ ! -d "$path_fonts_to_set" ] && mkdir -p "$path_fonts_to_set"

# change the working directory to the temporary root directory, and move 'ricty' font files and the source files used to generate 'ricty' to "$path_fonts_to_set"
cd "$path_tmproot" || exit
mv './sourcefiles/'*'.ttf' "$path_fonts_to_set"

# remove tmporary directory
remove_tmproot
