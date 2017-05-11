# Paths, variables, etc
export VISUAL=vim
export SVN_EDITOR=vim

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

#
# Colors for Darwin's ls
#
export LSCOLORS=ExGxcxdxBxegedabagacad

export PATH=/usr/local/share/python/:/usr/local/bin:$PATH:/sbin:/usr/sbin:~/.tmux:~/bin

#
# Enable comments on CLI
# 
setopt interactivecomments

#
# Docker-machone
#
#export DOCKER_HOST=tcp://192.168.99.100:2376
#export DOCKER_MACHINE_NAME=default
#export DOCKER_TLS_VERIFY=1

#export DOCKER_HOST=tcp://192.168.59.103:2376
#export DOCKER_CERT_PATH=/Users/dmytro/.boot2docker/certs/boot2docker-vm
#export DOCKER_CERT_PATH=/Users/dmytro/.docker/machine/certs/

#export VAGRANT_CWD=/Users/dmytro/Development/coreos-vagrant/vagrant
export VAGRANT_CWD=/Users/dmytro/Development/dotfiles/vagrant.d

#
#
# https://github.com/tmux/tmux/issues/475
export EVENT_NOKQUEUE=1

export GOPATH=~/Development/gopath/
