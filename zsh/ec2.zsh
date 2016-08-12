[ -d /usr/libexec/java_home ] && export JAVA_HOME="$(/usr/libexec/java_home)"
[ -d /usr/libexec/java_home ] && export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"

if [ -d /usr/local/aws/bin ]; then 
  source /usr/local/aws/bin/aws_zsh_completer.sh
  PATH=/usr/local/aws/bin/:$PATH
fi
