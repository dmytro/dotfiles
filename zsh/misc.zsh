# Repeat the last word in the command line by pressing ESC m (handy at renaming files)
bindkey "^[m" copy-prev-shell-word

# Better word separators for Z line editor (ctrl-w will become much more useful)
WORDCHARS=''

# No "zsh: sure you want to delete all the files in..." at rm
setopt rmstarsilent

# Emacs editing mode
set -o emacs
