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

# Install fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
mkdir -p $HOME/.local/share/fonts
unzip FiraCode.zip -d $HOME/.local/share/fonts
fc-cache -fv
rm FiraCode.zip

# Setup config files
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/aliases.zsh $HOME/.aliases.zsh
ln -s $(pwd)/zshrc $HOME/.zshrc
mkdir -p $HOME/.config
ln -s $(pwd)/config/nvim $HOME/.config/nvim

# nvim +'PlugInstall --sync' +qa
pip3 install pynvim
