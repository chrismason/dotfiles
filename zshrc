export ZSH=$HOME/.oh-my-zsh

export GOPATH=/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:"$HOME/.local/bin"

export GPG_TTY=$(tty)

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases.zsh

export GPG_TTY=$(tty)
