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
tar -xf "$TMP_NVIM_DIR/nvim-linux64.tar.gz" --directory $TMP_NVIM_DIR
cp -RT "$TMP_NVIM_DIR/nvim-linux64/" "$HOME/.local" >/dev/null

rm -rf $TMP_NVIM_DIR

# Setup config files
rm -rf $HOME/.gitconfig
ln -s $(pwd)/gitconfig-codespaces $HOME/.gitconfig

ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/aliases.zsh $HOME/.aliases.zsh
ln -s $(pwd)/zshrc $HOME/.zshrc

rm -rf $HOME/.config
mkdir $HOME/.config
ln -s $(pwd)/config/nvim $HOME/.config/nvim

pip3 install pynvim
