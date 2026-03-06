# ---------------------------------------------------------------------------- #
# path {{{
typeset -U path                             # set path variable as UNIQUE, run 'typeset +U' to check unique variables
path=(
   $HOME/dev/bin
   $HOME/dev/bin2
   $HOME/.local/bin
   $HOME/.cargo/bin
   $HOME/.bun/bin
   $HOME/go/bin
   /usr/local/go/bin
   $path
)
# }}}

# ---------------------------------------------------------------------------- #
# prompt {{{
setopt PROMPT_SUBST
PS1='%B%F{2}%~%f%b %# '
RPS1='%(?.[%?].[%F{1}%B%?%f%b])'
# %B%b - start stop bold mode
# %F%f - color
# %~   - current working directory, starting with ~
# %#   - % or # depending if root or not
# more sutff ~> https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# }}}

# some generic options
setopt NO_BEEP         # disable terminal bell sound
setopt AUTO_CD         # allow to cd without typing cd
setopt EXTENDED_GLOB   # enable extended globbing patterns

# ---------------------------------------------------------------------------- #
# bindkey {{{
# fyi
#   -e  - '-e' sets keymap to "EMACS" mode, for stuff like ctrl+a, ctrl+u, etc...
#   -s  - '-s' binds a key to a string that gets typed out - it's esentially a MACRO
#
bindkey -e  # '-e' sets keymap to "EMACS" mode, for stuff like ctrl+a, ctrl+u, etc...

bindkey "^[[1~" beginning-of-line       # home
bindkey "^[[4~" end-of-line             # end
bindkey "^[[3~" delete-char-or-list     # delete
#bindkey "^[[24~" universal-argument     # F12
#bindkey "^T" history-incremental-search-forward

bindkey -s '^f' 'j -t^m' # bind CTRL-F to `j` command
# }}}

# ---------------------------------------------------------------------------- #
# history {{{
HISTSIZE=1000001
SAVEHIST=1000001
HISTFILE=~/.history
setopt INC_APPEND_HISTORY   # append command to history "imidiately" (instead of when shell exits)
setopt EXTENDED_HISTORY     # add timestamp to history
setopt SHARE_HISTORY        # share history across all open sessions
setopt HIST_IGNORE_SPACE    # don't add command to history if it starts with SPACE
setopt HIST_IGNORE_ALL_DUPS # remove duplicates, keeps history clean
# }}}

# ---------------------------------------------------------------------------- #
# exports {{{
export EDITOR="nvim"
export AI_CLI_TOOL=";"
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
export GOPATH=~/workspace/gopath
# }}}

# ---------------------------------------------------------------------------- #
# aliases {{{
# misc {{{
alias l="ls -lah --color=auto"
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
alias gw="git worktree"
alias gclean="git reset --hard HEAD && git clean -fd"
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
# functions autoload {{{
fpath=(~/.config/zsh/functions ~/.config/zsh/functions.local $fpath)
autoload -U ${fpath[1]}/*(:t)
autoload -U ${fpath[2]}/*(:t)
# }}}

# ---------------------------------------------------------------------------- #
# misc {{{
# requires `fzf` package
source <(fzf --zsh)

# requires `zsh-syntax-highlighting` package
# linux
test -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# mac
test -r /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && \
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# autocompletion # this is mainy for <TAB> <TAB> looking good
autoload -U compinit
compinit
zstyle ':completion:*' menu select
# }}}

# ---------------------------------------------------------------------------- #
# extra loads {{{
# load extra stuff if exists
test -r ~/.config/zsh/.zshrc.$(uname) && \
  source ~/.config/zsh/.zshrc.$(uname)

test -r ~/.zshrc.local && \
  source ~/.zshrc.local
# }}}

# TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO

## pyenv
#export PYENV_ROOT=${HOME}/.pyenv
#export PYENV_VIRTUALENV_DISABLE_PROMPT=1
#eval "$(pyenv init -)"
#eval "$(pyenv init --path)"
#eval "$(pyenv virtualenv-init -)"
