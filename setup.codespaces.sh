#!/bin/bash

set -eE -o pipefail
trap 'status=$?; printf "dotfiles: ERROR: Codespaces setup failed at line %s (exit %s).\n" "$LINENO" "$status" >&2; exit "$status"' ERR

exec > >(tee -i "$HOME/dotfiles_install.log")
exec 2>&1
set -x

for command in sudo apt-get dpkg; do
    if ! command -v "$command" >/dev/null 2>&1; then
        printf 'dotfiles: ERROR: Base image must provide %s for Codespaces setup.\n' "$command" >&2
        exit 1
    fi
done
sudo -n true

packages=(ca-certificates ripgrep fzf fontconfig python3-pip
    libicu-dev libssl-dev zlib1g libstdc++6 libgcc-s1 libgssapi-krb5-2)
for command in git python3 jq curl wget unzip tar gzip zsh; do
    if ! command -v "$command" >/dev/null 2>&1; then
        packages+=("$command")
    fi
done
sudo -n apt-get update
sudo -n apt-get install -y "${packages[@]}"

if ! command -v gh >/dev/null 2>&1; then
    # Use the maintained upstream packages rather than an older distro build.
    sudo -n mkdir -p -m 755 /etc/apt/keyrings /etc/apt/sources.list.d
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg |
        sudo -n tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
    sudo -n chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
    architecture="$(dpkg --print-architecture)"
    printf 'deb [arch=%s signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main\n' "$architecture" |
        sudo -n tee /etc/apt/sources.list.d/github-cli.list >/dev/null
    sudo -n apt-get update
    sudo -n apt-get install -y gh
fi

if ! command -v copilot >/dev/null 2>&1; then
    # Install on the shared PATH so the calling installer can use it immediately.
    curl -fsSL https://gh.io/copilot-install |
        sudo -n env PREFIX=/usr/local bash +x
fi

for command in git gh python3 jq copilot curl wget unzip tar gzip zsh; do
    if ! command -v "$command" >/dev/null 2>&1; then
        printf 'dotfiles: ERROR: Required executable %s is missing after installation.\n' "$command" >&2
        exit 1
    fi
done

TMP_RDM_DIR="/tmp/rdm"; mkdir -p $TMP_RDM_DIR
RDM_DOWNLOAD_URL="https://github.com/BlakeWilliams/remote-development-manager/releases/download/v0.0.6/rdm-linux-amd64"

sudo chsh -s "$(command -v zsh)" "$(whoami)"

wget $RDM_DOWNLOAD_URL -P $TMP_RDM_DIR
chmod +x $TMP_RDM_DIR/rdm-linux-amd64
mkdir -p "$HOME/.local/bin/"
mv $TMP_RDM_DIR/rdm-linux-amd64 "$HOME/.local/bin/rdm" >/dev/null
rm -rf $TMP_RDM_DIR

# https://github.com/neovim/neovim
if ! command -v nvim &> /dev/null
then
  gh release download --clobber --output /tmp/nvim.appimage --repo neovim/neovim-releases --pattern "nvim-linux-x86_64.appimage"
  chmod u+x /tmp/nvim.appimage

  /tmp/nvim.appimage --appimage-extract
  squashfs-root/AppRun --version

  sudo mv squashfs-root /
  sudo ln -s /squashfs-root/AppRun /usr/local/bin/nvim
fi

bash "$(dirname -- "${BASH_SOURCE[0]}")/setup.omnisharp.sh"

# Setup config files
ln -sfn "$(pwd)/gitconfig-codespaces" "$HOME/.gitconfig"

ln -sfn "$(pwd)/tmux.codespaces.conf" "$HOME/.tmux.conf"
ln -sfn "$(pwd)/aliases.zsh" "$HOME/.aliases.zsh"
ln -sfn "$(pwd)/zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.config"
ln -sfn "$(pwd)/config/nvim" "$HOME/.config/nvim"

if ! command -v npm &> /dev/null; then
    sudo apt-get install -y npm
fi

# pip3 install pynvim
