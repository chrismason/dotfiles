alias mkdir="mkdir -p"
alias vim="nvim"
alias k="kubectl"
alias t="tmux"
alias ta="tmux attach -t"
alias tn="tmux new-session -t"
alias tl="tmux list-sessions"
export EDITOR=nvim
export VISUAL=nvim

if [ -v CODESPACES ]; then
  alias xdg-open="rdm open"
  gh config set browser "rdm open"
fi