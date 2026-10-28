export ZSH=$HOME/.oh-my-zsh

export GOPATH="/go"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"/home/linuxbrew/.linuxbrew/bin"

export GPG_TTY=$(tty)

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases.zsh

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs --ignore-file "~/.ignore"'

export GPG_TTY=$(tty)

# Keep private shell configuration out of inherited xtrace output.
() {
    setopt localoptions noxtrace
    if [[ -r "$HOME/.config/dotfiles-private/github.zsh" ]]; then
        source "$HOME/.config/dotfiles-private/github.zsh"
    fi
}
