#!/bin/bash

set -x

mkdir -p $HOME/.config

# Setup config files
ln -s $(pwd)/gitconfig $HOME/.gitconfig
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/config/nvim $HOME/.config/nvim
ln -s $(pwd)/config/alacritty.yml $HOME/.config/alacritty.yml

# Update ncurses
# https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95
curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz && gunzip terminfo.src.gz
/usr/bin/tic -xe alacritty-direct,tmux-256color terminfo.src
rm terminfo.src
