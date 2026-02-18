
# ---------------------------------------------------------------------------- #
# aliases {{{
alias gtc="nvim ~/.config/ghostty/config"
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
