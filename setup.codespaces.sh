#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

chsh -s $(which zsh)

rm -f $HOME/.zshrc

apt-get update
apt-get install -y \
    ripgrep fzf fontconfig

# Install fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d ~/.local/share/fonts
fc-cache -fv
rm FiraCode.zip

# Install NeoVim Stable
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage /usr/local/bin/nvim

ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/aliases.zsh $HOME/.aliases.zsh
ln -s $(pwd)/zshrc $HOME/.zshrc
ln -s $(pwd)/config/nvim $HOME/.config/nvim

nvim +'PlugInstall --sync' +qa
pip3 install pynvim
