export ZSH=$HOME/.zsh

# Comment out if you don't want to include non-generic/experimental stuff
# DOTFILES_ONLY_GENERIC=1

if [[ $DOTFILES_ONLY_GENERIC = 1 ]]; then
  # exclude filenames starting with underscore
  for config_file ($ZSH/[^_]*.zsh) source $config_file
  #find $ZSH -name "*.zsh" -and \! -name "_*" -exec source {} +
else
  for config_file ($ZSH/*.zsh) source $config_file
  #find $ZSH -name "*.zsh" -exec source {} +
fi

unset config_file # clean-up

which dircolors > /dev/null && eval $(dircolors -b ~/.dircolors)

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

DISABLE_AUTO_TITLE=true

