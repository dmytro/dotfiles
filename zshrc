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

DISABLE_AUTO_TITLE=true

which fortune > /dev/null && ( echo; fortune; echo)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dmytro/Development/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dmytro/Development/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dmytro/Development/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dmytro/Development/google-cloud-sdk/completion.zsh.inc'; fi
