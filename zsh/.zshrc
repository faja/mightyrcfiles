# ---------------------------------------------------------------------------- #
# path {{{
typeset -U path                             # set path variable as UNIQUE, run 'typeset +U' to check unique variables
path=(
   $HOME/dev/bin
   $HOME/dev/bin2
   /opt/homebrew/bin
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

export PYENV_ROOT=${HOME}/.pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
#eval "$(pyenv init -)"
#eval "$(pyenv init --path)"
#eval "$(pyenv virtualenv-init -)"
# NOTE: penv is not initialised here, it takes too long :sad_pepe:
#       pyenv init - moved to custom function e_pyenv

export BUN_INSTALL="$HOME/.bun"
test -r ~/.bun/_bun && source ~/.bun/_bun
# }}}

# ---------------------------------------------------------------------------- #
# aliases {{{
# misc {{{
alias l="ls -lah --color=auto"
alias lg="ls -lah --color=auto | grep --color"
alias g="grep --color"
alias t="tmux"
alias ta="tmux attach"
alias tn="tmux new-session -d -c ~/dev -s"

alias v="nvim"
alias vd="nvim -d"
alias vt="nvim /tmp/tmp.txt"
alias ct="cat /tmp/tmp.txt"
alias ghc="nvim ~/.config/ghostty/config"

alias bn="basename \${PWD}"

alias cc="claude"
alias oc="opencode"
# my linux workstation specific - I use arch btw {{{
alias kkk="xset r rate 180 34"
alias tt_8='transset-df 0.8 --id $WINDOWID > /dev/null'
alias tt_9='transset-df 0.9 --id $WINDOWID > /dev/null'
alias tt_off='transset-df 1 --id $WINDOWID > /dev/null'
alias docker_start="sudo systemctl start docker"
alias cupsd_start="sudo systemctl start cups.service"
alias f="feh --auto-rotate --scale-down *"
alias nsa="sudo netctl stop-all"
alias nl="sudo netctl list"
alias nh="sudo netctl start wlp0s20f3-PrettyFlyForAWiFi-King"
alias shutdown_as_root='sudo shutdown -P now'
alias resize_image='convert -filter Cubic -resize 600'
alias resize_image_size='convert -strip -quality 90 ori.jpg new.jpg'
alias mplayer_camera_preview='mplayer -ontop -noborder -geometry "320x240-10-20" -tv driver=v4l2:device=/dev/video0 tv://'
alias mplayer_camera_preview='mplayer -ontop -noborder -geometry "320x240-10-20" -tv driver=v4l2:device=/dev/video0 tv://'
# }}}
# }}}
# git {{{
alias gs="git status"
alias gd="git diff"
alias gb="git branch"
alias gbr="git ls-remote --heads" # list branches on remote
alias gtr="git ls-remote --tags"  # list tags on remote
alias gsw='git switch $(git branch --format "%(refname:short)" | fzf)' # switch to different branch

alias gm="git pull origin master"
alias gmn="git pull origin main"
alias ggb="git status | head -1 | awk '{print \$NF}'"

alias gl="git log -1"
alias gll="git log --pretty=\"%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s\""
alias glf="git log -1 --pretty=format:'%s%n%n%b'"
alias glg="git log --grep "

alias gw="git worktree"
alias ggb="git status | head -1 | awk '{print \$NF}'" # ggb = get git branch :)
alias gclean="git reset --hard HEAD && git clean -fd"
alias git_branch_clean='git branch | grep -v master -v main | xargs -i git branch -D {}'
alias gb_rm="git branch | grep -vE 'main$|master$' | xargs git branch -D"

alias gfr='git fetch origin $(gbr | fzf | awk -F "refs\/heads\/" "{print \$2}" | sed -e "s/\(.*\)/\1:\1/")'
alias gwrm="git worktree list | fzf | awk -F'[' '{print \$2}' | awk -F']' '{print \$1}'  | xargs git worktree remove"
# }}}
# k8s and helm (and docker) {{{
alias d='docker'
alias drm='docker run --rm -i -t'

alias k="kubectl"
alias kg='kubectl get'
alias kd='kubectl describe'
alias ka="kubectl apply -f"
alias krm='kubectl delete'

alias kgp='kubectl get pods'
alias kdp='kubectl describe pods'
alias kgp_sort_by_node_name='kubectl get pods --sort-by='{.spec.nodeName}' -o wide'

alias klo='kubectl logs -f'
alias kex='kubectl exec -i -t'
alias kbb='kubectl run debug-pod --image=alpine:3 --rm -it --restart=Never --command -- /bin/sh'

alias h="helm"
alias hl='helm list'
alias hla='helm list -aA'
alias hs='helm secrets'

alias kns='kubens'
alias kctx='kubectx'
# }}}
# nomad {{{
# NOTE: n is custom shell script a wrapper around nomad
alias njs="n job status --verbose"
alias nji="n job inspect"
alias nas="n alloc status --verbose"
alias nal="n alloc logs"
alias nalt="n alloc logs -f -n 100 --tail"
alias nalt="n alloc logs -f -n 100 --tail -stderr"
alias nae="n alloc exec"
# }}}
# terraform {{{
alias tf="terraform"
alias tfv="terraform version"
alias tfi="terraform init"
alias tfa="terraform apply"
alias tfaaa="terraform apply -auto-approve"
alias tfp="terraform plan"
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
