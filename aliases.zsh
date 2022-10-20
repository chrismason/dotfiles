alias mkdir="mkdir -p"
alias vim="nvim"
alias k="kubectl"
alias t="tmux"
alias ta="tmux attach -t"
alias tn="tmux new-session -t"
alias tl="tmux list-sessions"
if command -v "bin/npm" &> /dev/null; then
  alias npm="bin/npm"
fi
export EDITOR=nvim
export VISUAL=nvim
