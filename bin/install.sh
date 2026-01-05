#!/bin/bash

install_location="$HOME/.local/opt/"

mkdir -p "$install_location"
cd "$install_location"

#rm -rf ./francinette

# download github
git clone --recursive https://github.com/jaynemaxwell/xicodomingues_francinette.git francinette

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

cd "$install_location/francinette" || exit

# the venv is now bundled except for packages

# activate venv
. venv/bin/activate

# install requirements
if ! python -m pip install -r requirements.txt ; then
	echo 'Problem launching the installer. Contact me (fsoares- on slack)'
	exit 1
fi

mkdir -p "$HOME/.local/bin/"
cd "$HOME/.local/bin/"

if [[ ":$PATH:" != *":$(pwd):"* ]]; then
	read -p "Do you wish to add ~/.local/bin/ to PATH ? [Y/n]" add_to_path
	if [[ ${add_to_path,,} != 'n' ]]; then
		echo "export PATH='$PATH:$(pwd)'" >> $HOME/.${SHELL##/bin/}rc
		echo "SUCCESS : appended directory to PATH"
	else
		echo "WARNING : selected install location not found in PATH (francinette will not be available unless manually inserted into scope)"
	fi
fi

echo "$install_location/francinette/tester.sh" > ./francinette
chmod a+x ./francinette

read -p "create \"paco\" shorthand ? [y/N]" is_paco_ok
if [[ ${is_paco_ok,,} = 'y' ]]; then
	echo "$install_location/francinette/tester.sh" > ./paco
	chmod a+x ./paco
fi

# print help
"$install_location/francinette/tester.sh" --help

printf "\033[33m... and don't forget, \033[1;37mpaco\033[0;33m is not a replacement for your own tests! \033[0m\n"
