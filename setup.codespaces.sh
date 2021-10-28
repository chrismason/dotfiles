#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

sudo chsh -s "$(which zsh)" "$(whoami)"

rm -f $HOME/.zshrc

sudo apt-add-repository -y ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y \
    ripgrep fzf fontconfig python3-pip neovim

mkdir -p $HOME/.config

# Setup config files
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/aliases.zsh $HOME/.aliases.zsh
ln -s $(pwd)/zshrc $HOME/.zshrc
ln -s $(pwd)/config/nvim $HOME/.config/nvim

pip3 install pynvim
