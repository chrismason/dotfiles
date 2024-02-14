#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

TMP_RDM_DIR="/tmp/rdm"; mkdir -p $TMP_RDM_DIR
TMP_OMNISHARP_DIR="/tmp/omnisharp"; mkdir -p $TMP_OMNISHARP_DIR
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
rm -rf $TMP_RDM_DIR

# https://github.com/neovim/neovim
if ! command -v nvim &> /dev/null
then
  gh release download --clobber --dir /tmp/ --repo neovim/neovim --pattern "nvim.appimage"
  chmod u+x /tmp/nvim.appimage

  /tmp/nvim.appimage --appimage-extract
  squashfs-root/AppRun --version

  sudo mv squashfs-root /
  sudo ln -s /squashfs-root/AppRun /usr/local/bin/nvim
fi

wget $OMNISHARP_DOWNLOAD_URL -P $TMP_OMNISHARP_DIR
unzip $TMP_OMNISHARP_DIR/omnisharp-linux-x64-net6.0.zip -d $TMP_OMNISHARP_DIR/omnisharp
mv $TMP_OMNISHARP_DIR/omnisharp "$HOME/.local/omnisharp" >/dev/null
chmod +x "$HOME/.local/omnisharp/OmniSharp.dll"
rm -rf $TMP_OMNISHARP_DIR

# Setup config files
rm -rf $HOME/.gitconfig
ln -s $(pwd)/gitconfig-codespaces $HOME/.gitconfig

ln -s $(pwd)/tmux.codespaces.conf $HOME/.tmux.conf
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

# pip3 install pynvim
