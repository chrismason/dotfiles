export ZSH=$HOME/.oh-my-zsh

export GOPATH="/go"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"/home/linuxbrew/.linuxbrew/bin"

export GOPROXY="https://goproxy.githubapp.com/mod,https://proxy.golang.org/,direct"
export GOPRIVATE=" "
export GONOPROXY=" "
export GONOSUMDB="github.com/github/*"

export GPG_TTY=$(tty)

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases.zsh

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs --ignore-file "~/.ignore"'

export GPG_TTY=$(tty)
