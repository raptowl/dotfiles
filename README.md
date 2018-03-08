# DOTFILES

This repository is hosting my config files and self-made scripts.

## How To Install

If you would like to use this repository, please prepare at least one command from these commands.
```
git
wget
curl
```
Then please run a command below.
```
curl -L https://raw.githubusercontent.com/raptowl/dotfiles/master/etc/download.sh | sh
```
(or)
```
wget -O - https://raw.githubusercontent.com/raptowl/dotfiles/master/etc/download.sh | sh
```
Running above command correctly, you can find that symbolic links is put at your home directory.
Then please re-login.
If your login shell is `bash`, `.bash_profile` would be read by your system.
An environment variable `DOTFILES`, which indicates the path to .dotfiles, is defined at `.bash_profile`.

Of course, you can clone this repository directly like below,
```
git clone https://github.com/raptowl/dotfiles.git $HOME/.dotfiles
```
but, this method would not execute putting symbolic links.
So you need to do it manually.

## Mechanism

### Environment Variable `DOTFILES`

This variable indicates the path to .dotfiles.
By default, this is set to `$HOME/.dotfiles`, and changing this value is not recommended.
The execution files such as in `bin/` and `dotmgr.sh` loads the original library file `lib.sh`.
To load the file, the execution files refer to this variable.

At present, this variable is defined at `.bash_profile` only.
It might be that you will be able to refer to this variable by `zsh`, `tcsh` later.

### Manager Script `dotmgr.sh` (incomplete)

This shell script manages the control of this dotfiles directory.
The location is root of this repository.
It has some subcommands.
`deploy`: put symbolic links of configuration files to home directory.
`undeploy`: remove symbolic links of configuration files from home directory.
`install`(incomplete): build specific software.
`uninstall`(incomplete): remove built software.

### Shared Library `lib.sh` (incomplete)

This shell script is a shared library.
The location is `etc/lib.sh`.
This file store a lot of useful variables and functions.
The original shell script such as in `bin/` and `dotmgr.sh` loads this file.

### Downloader Script `download.sh`

This shell script helps that you download and install this repository.
The location is `etc/download.sh`.
This script executes downloading this repository by `git`, `wget` or `curl`, and putting symbolic links of configuration files (.bash\_profile, .vimrc, ...) to your home directory automatically.
In general, the chance to run this script is just once.

