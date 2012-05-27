## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_all_dups # don't store duplicates in history at all, even if they are *not* typed in a row (as opposed to hist_ignore_dups)
# setopt share_history
setopt hist_verify # don't run the command from history immediately, rather wait for another "enter" hit
# setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first # when the history file becomes full, start removing duplicates first
