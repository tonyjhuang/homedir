export PATH="/usr/local/opt/mongodb-community@3.2/bin:$PATH"

export PROMPT='%F{249}%2~%f %# '
export RPROMPT='%F{249}%*%f'

export EDITOR='emacs -nw'
alias emacs='emacs -nw'

function cs { cd "$@" && ls; }
function mkcs { mkdir "$@" && cd "$@"; }
alias ..='cs ..'
alias gs='git status'
alias gb='git branch'
alias gam='git commit -am'

alias ll='ls -alF'
alias la='ls -A'


# ignore hash comments
set -k
alias python=/usr/local/bin/python3

# https://stackoverflow.com/questions/444951/zsh-stop-backward-kill-word-on-directory-delimiter
# only for zsh
autoload -U select-word-style
select-word-style bash
