#!/bin/bash
#===============================================================================
#
#          FILE:  install_dotfiles.sh
# 
#         USAGE:  ./install_dotfiles.sh 
# 
#   DESCRIPTION: This script will donwload and install all dependecies and plugins. 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  git, unzip
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Kamil Porwit (), kamilporwit93@gmail.com
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  14.08.2020 08:56:56 CEST
#      REVISION:  ---
#===============================================================================

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
    sudo apt-get install git -y
fi
printf " Found git at %s.\n Checking out Vundle..." "$(which git)"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

printf " Done.\nChecking out tmp..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

printf " Done.\nInstalling shellcheck..."
sudo apt-get install shellcheck -y

printf " Done.\nInstalling BASH vim plugin...\n"
printf "Checking whether unzip is installed..."
if ! which unzip; then
    printf " unzip not installed\n"
    sudo apt-get install unzip -y
fi
wget -O bash-support.zip http://www.vim.org/scripts/download_script.php?src_id=9890
unzip bash-support.zip -d "$VIMDIR" && rm bash-support.zip #need to type filetype plugin on in vim 

printf " Done.\n Installing powerline-fonts..."
sudo apt-get install fonts-powerline -y

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

printf " Done.\n Setting up git aliases..."
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

printf " Done.\n Everything went ok. Please run vim and run :PluginInstall command adn prefix + I command in tmux"
