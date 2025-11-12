#!/bin/bash

let install_location="$HOME"/.local/opt/

mkdir -p "$install_location"
cd "$install_location"

rm -rf francinette

# download github
git clone --recursive https://github.com/xicodomingues/francinette.git

# TODO handle rootless execution
: '
if [ "$(uname)" != "Darwin" ]; then
	echo "Admin permissions needed to install C compilers, python, and upgrade current packages"
	case $(lsb_release -is) in
		"Ubuntu")
			sudo apt update
			sudo apt upgrade
			sudo apt install gcc clang libpq-dev libbsd-dev libncurses-dev valgrind -y
			sudo apt install python-dev python3-pip -y
			sudo apt install python3-dev python3-venv python3-wheel -y
			pip3 install wheel
			;;
		"Arch")
			sudo pacman -Syu
			sudo pacman -S gcc clang postgresql libbsd ncurses valgrind --noconfirm
			sudo pacman -S python-pip --noconfirm
			pip3 install wheel
			;;
	esac
fi
'

cd "$install_location"/francinette || exit

# start a venv inside francinette
if ! python3 -m venv venv ; then
	echo "Please make sure than you can create a python virtual environment"
	echo 'Contact me if you have no idea how to proceed (fsoares- on slack)'
	exit 1
fi

# activate venv
. venv/bin/activate

# install requirements
if ! pip3 install -r requirements.txt ; then
	echo 'Problem launching the installer. Contact me (fsoares- on slack)'
	exit 1
fi

cd "$HOME"/.local/bin/

if [[ ":$PATH:" != *":$(pwd):"* ]]; then
	echo "adding ~/.local/bin/ to PATH"
	export PATH="$PATH:$(pwd)"
fi

echo "$install_location/francinette/tester.sh" > ./francinette
chmod a+x ./francinette

read -p "create \"paco\" shorthand ? [y/N]" is_paco_ok
if [ ${is_paco_ok,,} == 'y' ]; then
	echo "$install_location/francinette/tester.sh" > ./paco
	chmod a+x ./paco
fi

# print help
"$HOME"/francinette/tester.sh --help

printf "\033[33m... and don't forget, \033[1;37mpaco\033[0;33m is not a replacement for your own tests! \033[0m\n"
