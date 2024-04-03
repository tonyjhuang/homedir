alias emacs='emacs -nw'
function cs { cd "$@" && ls; }
alias ..='cs ..'
function mkcs { mkdir "$@" && cd "$@"; }

export CLIENT_SECRETS="$HOME/creds/integral-client-secret.json"

alias devsite2='/google/data/ro/projects/devsite/devsite2'
alias bluze=/google/bin/releases/blueprint-bluze/public/bluze
alias rcit=/google/bin/releases/borg-sre/rcit_cli/rcit

source ~/.bash_aliases_gssh

function gcels { gcloud compute instances list --project $1; }

function gr { grants request $1; }

alias g4ls='g4 myclients'

alias gs='git status'
alias gb='git branch'
alias gp='git push'
alias gco='git checkout'
alias gpr='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gam='git commit -am'
alias gpmam='git fetch origin master:master && git merge master'
function gfb { git co "tonyjhuang/$1"; }

alias lance='/google/data/rw/teams/firebase-database/lance'
alias gcloud='/google/data/ro/teams/cloud-sdk/gcloud'
alias jadep='/google/data/ro/teams/jade/jadep'
alias apido='/google/data/ro/teams/oneplatform/apido'
alias pod='/google/data/ro/teams/pod/tools/pod'
alias prodspec='/google/data/ro/teams/prodspec/prodspec'
alias inception_tool='/google/data/ro/teams/oneplatform/inception_tool'
alias tm='/google/data/ro/teams/tenantmanager/tools/tm'
alias workflow_cli='/google/bin/releases/cep-monitoring/public/workflow_cli'
alias aclcheck='/google/data/ro/projects/ganpati/aclcheck'

function check_port { netstat -ltnp | grep $1; }

function bequt {
  /google/src/head/depot/google3/devtools/bequt/scripts/bequt.sh \
    --permalinkBase=http://localhost.corp.google.com:8181 \
    --loginservicenames=localhost.corp.google.com:8181
}
alias rpcstudio='/google/bin/releases/frameworks-rpc-studio/prod/run.sh'

function gcloud_activate { gcloud config configurations activate $1; }

export NODE=firebase-storage.control-plane
export MDB=firebase-storage-control-plane

alias nss-start='sbt -java-home /usr/local/buildtools/java/jdk8 server/start'

function email_to_hex {
  stubby call blade:gaia-backend GaiaServerStubby.Lookup "Username: \"$1\"" | \
    grep UserID | \
    sed -En "s/UserID: (.*)/\1/p" | \
    xargs printf "0x%x\n";
}

function hex_to_email {
  stubby call blade:gaia-backend GaiaServerStubby.Lookup "UserID: {ID: $(printf %d $1)}" | \
  grep Email: | \
  sed -En "s/Email: \"(.*)\"/\1/p" | \
  head -1
}

FBQS='//java/com/google/firebase/storage/boq/bucketquota'

function g4_changelog() {
  OLDCL=$(($1 + 1))
  NEWCL=$2
  G3_PATH=$3
  g4 changes -s submitted $G3_PATH...@$OLDCL,$NEWCL \
    | awk '{print $2}'| sort -r | uniq | xargs -n1 g4 describe -s
}

function changelog_storage() {
  g4_changelog $1 $2 //depot/google3/java/com/google/firebase/storage/
}

function changelog_metadata() {
  g4_changelog $1 $2 //depot/google3/firebase/database/metadata_service/
}

alias bstp='/google/bin/releases/blobstore2/bstp/bstp'

# go/cider-v-debugging#allow_ptrace
alias allow_ptrace='/google/bin/releases/cider/dbg/allow_ptrace'
