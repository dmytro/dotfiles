# Reload .zshrc
alias reload='source ~/.zshrc'

# ls-command: --color option is not standard on OSX, but with coreutils installed it'd work - hence the check
ls --color > /dev/null 2>&1
if [[ $? == 0 ]]; then
  alias ls='ls -F --color'
else
  alias ls='ls -G' # fallback to Darwin poor colors
fi

# Generic
alias l='ls -l'
alias ll='ls -Al'
alias lll='ls -al'

alias psgrep='ps aux | grep $1'
#alias s='screen'
#alias sr='screen -r'

alias tailf='tail -f -n200'

alias k='kill -9'

# Rails
alias r='rails'

function ss {
  if [ -e script/rails ]; then
    script/rails server $@
  else
    script/server $@
  fi
}
function sc {
  if [ -e script/rails ]; then
    script/rails console $@
  else
    script/console $@
  fi
}
function sg {
  if [ -e script/rails ]; then
    script/rails generate $@
  else
    script/generate $@
  fi
}
function sp {
  if [ -e script/rails ]; then
    script/rails plugin $@
  else
    script/plugin $@
  fi
}

alias rmlogs='rm -f log/*.log'
alias rst='touch tmp/restart.txt'

# function rake { if [ -e ./Gemfile.lock ]; then bundle exec rake "$@"; else /usr/bin/env rake "$@"; fi; }
# function cucumber { if [ -e ./Gemfile.lock ]; then bundle exec cucumber "$@"; else cucumber "$@"; fi; }
# function rspec { if [ -e ./Gemfile.lock ]; then bundle exec rspec "$@"; else rspec "$@"; fi; }

alias killruby='sudo killall -9 ruby'

# Capistrano
alias capd="cap deploy"
alias capdr="cap deploy:restart"

# NGINX
# restart nginx
alias nginxr="sudo nginx -s quit && sudo nginx"

# git
alias g='git status'
alias ga='git add'
alias gl='git log'
alias gp='git push'
alias gf='git fetch'
alias gd='git diff'
alias gm='git merge'
alias gc='git commit -v'
alias gco='git checkout'
#alias go='git checkout' # danger to confuse with 'ga'
alias gr='git rebase'
alias gca='git commit -v -a'
alias gcaa='git commit -v -a --amend'
alias gb='git branch'
alias gba='git branch -a'
alias gitx='gitx --all'
alias gcl='git clone'
alias gsp='git stash pop'
alias gst='git stash'
alias gR='git reset --hard'

alias gsa='git submodule add'



extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xjf $1      ;;
      *.tar.gz)   tar xzf $1      ;;
      *.bz2)      bunzip2 $1      ;;
      *.rar)      rar x $1        ;;
      *.gz)       gunzip $1       ;;
      *.tar)      tar xf $1       ;;
      *.tbz2)     tar xjf $1      ;;
      *.tgz)      tar xzf $1      ;;
      *.zip)      unzip $1        ;;
      *.Z)        uncompress $1   ;;
      *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

