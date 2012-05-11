# Directory operations
#

# Some handy options
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups

alias ..="cd .."
# For something like:
#   mv file.txt ....
#   cd .....
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# Show directories stack
alias d='dirs -v'

# Move around the stack
alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

# Misc
alias md='mkdir -p'
# alias .='pwd'

function take() {
  [ -n "$1" ] && mkdir -p "$@" && cd "$1";
}

function cdl() {
  [ -n "$1" ] && cd "$1" && ls -al;
}

# Change into a directory by simply typing it
# setopt auto_cd
