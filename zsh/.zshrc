
# ---------------------------------------------------------------------------- #
# aliases {{{
# misc {{{
alias t="tmux"
alias ta="tmux attach"
alias tn="tmux new-session -d -s"

alias ghc="nvim ~/.config/ghostty/config"

alias kkk="xset r rate 180 34"
# }}}
# git {{{
# }}}
# k8s {{{
alias k="kubectl"
alias ka="kubectl apply -f"
alias h="helm"
# }}}
# terraform {{{
alias tf="terraform"
alias tfv='terraform version'
alias tfi='terraform init'
alias tfa='terraform apply'
alias tfaaa='terraform apply -auto-approve'
# }}}
# jumps {{{
alias mm="cd ~/GitRepos/PERSONAL/mightymanuals"
alias mp="cd ~/GitRepos/PERSONAL/mightyplay"
alias mr="cd ~/GitRepos/PERSONAL/mightyrcfiles"
# }}}
# }}}


# ---------------------------------------------------------------------------- #
# extra loads {{{
# load extra stuff if exists
if test -r ~/.config/zsh/.zshrc.$(uname); then
  . ~/.config/zsh/.zshrc.$(uname)
fi

if test -r ~/.zshrc.local; then
  . ~/.zshrc.local
fi
