# $Id: //depot/google3/googledata/corp/puppet/goobuntu/common/modules/shell/files/bash/skel.bashrc#1 $
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# PATH
PATH=$PATH:/usr/local/google/eclipse46_tonyjhuang/stable/:/google/data/ro/projects/placer/:/google/data/ro/users/ho/hooper/:/google/data/ro/teams/plx/:/google/data/ro/teams/travel-hotels/versions/utilities/prod-live/

# prompt
export DEFAULT='\[\e[0m\]'
export DIM='\[\e[2m\]' 
export WHITE='\[\e[1;37m\]'
export BLACK='\[\e[0;30m\]'
export BLUE='\[\e[0;34m\]'
export LIGHT_BLUE='\[\e[1;34m\]'
export GREEN='\[\e[0;32m\]'
export LIGHT_GREEN='\[\e[1;32m\]'
export CYAN='\[\e[0;36m\]'
export LIGHT_CYAN='\[\e[1;36m\]'
export RED='\[\e[0;31m\]'
export LIGHT_RED='\[\e[1;31m\]'
export PURPLE='\[\e[0;35m\]'
export LIGHT_PURPLE='\[\e[1;35m\]'
export BROWN='\[\e[0;33m\]'
export YELLOW='\[\e[1;33m\]'
export GRAY='\[\e[0;30m\]'
export LIGHT_GRAY='\[\e[0;37m\]'

export EDITOR='emacs -nw'
alias emacs='emacs -nw'
export PS1="${DIM}[${DEFAULT}${BLUE}G${RED}o${YELLOW}o${BLUE}g${GREEN}l${RED}e${DEFAULT}${DIM} \T]${DEFAULT} \W \$ "
function cs { cd "$@" && ls; }
function cm_get {
  /google/data/ro/teams/cliquemap/cliquemap_util getvalue \
    spanner:///span/nonprod/travel-hotels-dev:cliquemap-configuration/yi.hotel_attachments \
    2 $@ | stubby totext "" "ads_travel.HotelItineraryPriceHistory" --proto2 --globaldb
}

alias btest='blaze test --test_output=errors'
alias ..='cs ..'

# caps -> ctrl
setxkbmap -layout us -option ctrl:nocaps

# set title
function get_title {
  local _outvar=$1
  if [[ `pwd` =~ /google/src/cloud/tonyjhuang/(.*)/google3 ]] ; then
    eval $_outvar=${BASH_REMATCH[1]}
  else
    eval $_outvar=`pwd`
  fi
}

PROMPT_COMMAND='echo -en "\033]0; `title=''; get_title title; echo $title` \a"'

# copy to clipboard
alias xc='xargs echo -n | xclip -selection c &> /dev/null'


alias hpsbt='/bigtable-blade/travel-hotels-hotel-price-srv-table:hotel_price'
alias fu=fileutil

fix_auth() {
  N_AGENTS=$(ls /tmp/ssh-*/agent* | wc -l)
  if [ -e "$SSH_AUTH_SOCK" ]; then
    echo "$SSH_AUTH_SOCK still valid."
  else
    echo "$SSH_AUTH_SOCK not valid anymore, looking for new agents"
    if [ "$N_AGENTS" -ne "1" ]; then
      echo "Found $N_AGENTS agents, can't decide which to use. Exiting..."
    else
      SSH_AUTH_SOCK=$(ls /tmp/ssh-*/agent*)
      echo "Setting SSH_AUTH_SOCK to $SSH_AUTH_SOCK."
    fi
  fi
}


alias lt='blaze build -c opt //travel/hotels/servers/hps:hotel_price_service && borgcfg production/borg/travel-hotels-dev/ym/dev_hotel_price_service.borg --borguser=travel-hotels-dev --user=travel-hotels-dev --vars="service_name_prefix=tonyjhuang_lt,binary_path=blaze-bin/travel/hotels/servers/hps/hotel_price_service,load_test=true,features_override=GLOBAL_TIPS_PRICE_ANOMALY_TIP " reload --skip_confirmation'
alias multichange='g4 client --set_option multichange'
alias fastgws=/google/src/head/depot/google3/gws/tools/fastgws/fastgws
alias insights="travel/hotels/servers/insights"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
