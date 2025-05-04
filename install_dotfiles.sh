#!/bin/bash
#===============================================================================
#
#          FILE:  install_dotfiles.sh
# 
#         USAGE:  ./install_dotfiles.sh 
# 
#   DESCRIPTION: This script will download and install all dependecies and plugins. 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  git, unzip
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Kamil Porwit (), kamilporwit93@gmail.com
#       COMPANY:  
#       VERSION:  1.1
#       CREATED:  14.08.2020 08:56:56 CEST
#      REVISION:  ---
#===============================================================================

declare -A OS_INFO;
OS_INFO[/etc/arch-release]=pacman
OS_INFO[/etc/debian_version]=apt-get

for f in ${!OS_INFO[@]}
do
    if [[ -f $f ]];then
		PACKAGE_MANAGER="${OS_INFO[$f]}"
        printf "Package manager: %s\n" "$PACKAGE_MANAGER"
    fi
done

declare -A INSTALL_FLAG;
INSTALL_FLAG[pacman]="-S --noconfirm"
INSTALL_FLAG[apt-get]="install -y"

INSTALL_COMMAND="${PACKAGE_MANAGER} ${INSTALL_FLAG[$PACKAGE_MANAGER]}"
printf "Install Command: %s\n" "$INSTALL_COMMAND"

printf "Checking directories..."
VIMDIR="$HOME/.vim"
TMUXDIR="$HOME/.tmux"
if [ ! -d "$VIMDIR" ]; then
    mkdir "$VIMDIR"
fi
if [ ! -d "$TMUXDIR" ]; then
    mkdir "$TMUXDIR"
fi

printf "Checking whether GIT is installed..."
if ! which git; then
    printf " GIT not installed\n"
    sudo "$INSTALL_COMMAND" git -y
fi
printf " Found git at %s.\n Checking out Vundle..." "$(which git)"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

printf " Done.\nChecking out tmp..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

printf " Done.\nInstalling shellcheck..."
sudo $INSTALL_COMMAND shellcheck

printf " Done.\nInstalling yamllint..."
sudo $INSTALL_COMMAND yamllint

printf " Done.\nInstalling BASH vim plugin...\n"
printf "Checking whether unzip is installed..."
if ! which unzip; then
    printf " unzip not installed\n"
    sudo $INSTALL_COMMAND unzip
fi
wget -O bash-support.zip http://www.vim.org/scripts/download_script.php?src_id=9890
unzip bash-support.zip -d "$VIMDIR" && rm bash-support.zip #need to type filetype plugin on in vim 

printf " Done.\n Installing powerline-fonts..."
sudo $INSTALL_COMMAND fonts-powerline
#
printf " Done.\n Copying rc files to the %s directory" "$HOME"
cp ./.vimrc "$HOME"
cp ./.tmux.conf "$HOME"

printf " Done.\n Create backupdir swap and undo dir for vim..."
if [ ! -d "$VIMDIR/backup" ]; then
    mkdir "$VIMDIR/backup"
fi
if [ ! -d "$VIMDIR/swap" ]; then
    mkdir "$VIMDIR/swap"
fi
if [ ! -d "$VIMDIR/undo" ]; then
    mkdir "$VIMDIR/undo"
fi
printf " Done.\n Switching the dirs in .vimrc..."
sed -i "s:set backupdir=.*:set backupdir=$VIMDIR/backup//:" "$HOME/.vimrc"
sed -i "s:set directory=.*:set directory=$VIMDIR/swap//:" "$HOME/.vimrc"
sed -i "s:set undodir=.*:set undodir=$VIMDIR/undodir//:" "$HOME/.vimrc"

printf " Done.\n Setting up git identity..."
git config --global user.email 'kamilporwit93@gmail.com'
git config --global user.name 'Kamil Porwit'

printf " Done.\n Setting up git aliases..."
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

printf " Done.\n Everything went ok. Please run vim and run :PluginInstall command adn prefix + I command in tmux\n"
