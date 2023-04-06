#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

TMP_NVIM_DIR="/tmp/neovim"; mkdir -p $TMP_NVIM_DIR
TMP_RDM_DIR="/tmp/rdm"; mkdir -p $TMP_RDM_DIR
TMP_OMNISHARP_DIR="/tmp/omnisharp"; mkdir -p $TTMP_OMNISHARP_DIR
NVIM_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"
RDM_DOWNLOAD_URL="https://github.com/BlakeWilliams/remote-development-manager/releases/latest/download/rdm-linux-amd64"
OMNISHARP_DOWNLOAD_URL="https://github.com/OmniSharp/omnisharp-roslyn/releases/latest/download/omnisharp-linux-x64-net6.0.zip"

sudo chsh -s "$(which zsh)" "$(whoami)"

rm -f $HOME/.zshrc

sudo apt-get update
sudo apt-get install -y \
    ripgrep fzf fontconfig python3-pip

wget $RDM_DOWNLOAD_URL -P $TMP_RDM_DIR
chmod +x $TMP_RDM_DIR/rdm-linux-amd64
mkdir -p $HOME/.local/bin/
mv $TMP_RDM_DIR/rdm-linux-amd64 "$HOME/.local/bin/rdm" >/dev/null

wget $NVIM_DOWNLOAD_URL -P $TMP_NVIM_DIR
chmod u+x $TMP_NVIM_DIR/nvim.appimage
$TMP_NVIM_DIR/nvim.appimage --appimage-extract
mv squashfs-root "$HOME/.local/nvim"
sudo ln -s "$HOME/.local/nvim/AppRun" /usr/bin/nvim
rm -rf $TMP_NVIM_DIR

wget $RDM_DOWNLOAD_URL -P $TMP_RDM_DIR
chmod +x $TMP_RDM_DIR/rdm-linux-amd64
mkdir -p $HOME/.local/bin/
mv $TMP_RDM_DIR/rdm-linux-amd64 "$HOME/.local/bin/rdm" >/dev/null

# Setup config files
rm -rf $HOME/.gitconfig
ln -s $(pwd)/gitconfig-codespaces $HOME/.gitconfig

ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/aliases.zsh $HOME/.aliases.zsh
ln -s $(pwd)/zshrc $HOME/.zshrc

rm -rf $HOME/.config
mkdir $HOME/.config
ln -s $(pwd)/config/nvim $HOME/.config/nvim

if [ -d "/workspaces/github/bin/" ]; then
    sudo ln -s /workspaces/github/bin/npm /usr/local/bin/npm
    sudo ln -s /workspaces/github/bin/tsc /usr/local/bin/tsc
    sudo ln -s /workspaces/github/bin/prettier /usr/local/bin/prettier
    sudo ln -s /workspaces/github/bin/eslint /usr/local/bin/eslint
    sudo ln -s /workspaces/github/bin/rubocop /usr/local/bin/rubocop
    sudo ln -s /workspaces/github/bin/srb /usr/local/bin/srb
    sudo ln -s /workspaces/github/bin/bundle /usr/local/bin/bundle
    sudo ln -s /workspaces/github/bin/solargraph /usr/local/bin/solargraph
elif ! command -v npm &> /dev/null; then
    sudo apt-get install -y npm
fi

pip3 install pynvim
