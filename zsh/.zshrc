
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
alias gs="git status"
alias gd="git diff"
alias gm="git pull origin master"
alias gmn="git pull origin main"
alias ggb="git status | head -1 | awk '{print \$NF}'"
alias gl1="git log -1"
alias gl="git log --all --decorate --oneline --graph"
alias glf="git log -1 --pretty=format:'%s%n%n%b'"
alias glg="git log --grep "
alias gw='git worktree'
# }}}
# k8s {{{
alias k="kubectl"
alias ka="kubectl apply -f"
alias h="helm"
# }}}
# terraform {{{
alias tf="terraform"
alias tfv="terraform version"
alias tfi="terraform init"
alias tfa="terraform apply"
alias tfaaa="terraform apply -auto-approve"
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
