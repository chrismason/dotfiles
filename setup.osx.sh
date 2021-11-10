#!/bin/bash

set -x

mkdir -p $HOME/.config

# Setup config files
ln -s $(pwd)/gitconfig $HOME/.gitconfig
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/config/nvim $HOME/.config/nvim
ln -s $(pwd)/config/alacritty.yml $HOME/.config/alacritty.yml
