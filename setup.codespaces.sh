#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

TMP_NVIM_DIR="/tmp/neovim"; mkdir -p $TMP_NVIM_DIR
NVIM_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"

sudo chsh -s "$(which zsh)" "$(whoami)"

rm -f $HOME/.zshrc

sudo apt-get update
sudo apt-get install -y \
    ripgrep fzf fontconfig python3-pip
    
wget $NVIM_DOWNLOAD_URL -P $TMP_NVIM_DIR
tar -xzf "$TMP_NVIM_DIR/nvim-linux64.tar.gz"
cp -RT "$TMP_NVIM_DIR/nvim-linux64/" "$HOME/.local" >/dev/null

rm -rf $TMP_NVIM_DIR

mkdir -p $HOME/.config

# Setup config files
ln -s $(pwd)/gitconfig $HOME/.gitconfig
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/aliases.zsh $HOME/.aliases.zsh
ln -s $(pwd)/zshrc $HOME/.zshrc
ln -s $(pwd)/config/nvim $HOME/.config/nvim

pip3 install pynvim
