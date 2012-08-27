# Only for Mac OSX (Darwin)
if [[ $(uname) = "Darwin" ]]; then
  export PATH=/opt/local/bin:$PATH
  export PATH=$PATH:/usr/local/node/bin # Add node
fi
