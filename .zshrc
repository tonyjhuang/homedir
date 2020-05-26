export PATH="/usr/local/opt/mongodb-community@3.2/bin:$PATH"

export PROMPT='%F{249}%2~%f %# '
export RPROMPT='%F{249}%*%f'

export EDITOR='emacs -nw'
alias emacs='emacs -nw'

function cs { cd "$@" && ls; }
alias ..='cs ..'
alias gs='git status'
alias gb='git branch'
alias gp='git push'
alias gpr='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gam='git commit -am'

function mkcs { mkdir "$@" && cd "$@"; }

# ignore hash comments
set -k
alias python=/usr/local/bin/python3

function start_mongo { mongod --config /usr/local/etc/mongod.conf --fork; }

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_251.jdk/Contents/Home

# https://stackoverflow.com/questions/444951/zsh-stop-backward-kill-word-on-directory-delimiter
autoload -U select-word-style
select-word-style bash

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Applications/google-cloud-sdk/path.zsh.inc' ]; then . '/Applications/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Applications/google-cloud-sdk/completion.zsh.inc' ]; then . '/Applications/google-cloud-sdk/completion.zsh.inc'; fi

export GOOGLE_APPLICATION_CREDENTIALS=/Users/tonyjhuang/dev/WaniKaniRemindersWeb/web/key.json

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# added by travis gem
[ ! -s /Users/tonyjhuang/.travis/travis.sh ] || source /Users/tonyjhuang/.travis/travis.sh

