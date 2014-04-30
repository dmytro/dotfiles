
# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt redhat
PS1="[%n@%m %1~]$ "

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
precmd() {
    vcs_info 
}

setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true

# Colors
# zstyle ':vcs_info:*'    formats "%f[%%n@%%m %1~] $ " "%F{5}%a %m%u%c %F{6}%b:%F{3}%r/%S" 
zstyle ':vcs_info:*'    formats "%f[%%n@%%m %1~] $ " "%f%a %F{3}%m%u%c %f%b:%r/%S" 
zstyle ':vcs_info:*'    nvcsformats   "%f[%n@%m %1~]$ " ""
zstyle ':vcs_info:*'    actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '

PROMPT='${vcs_info_msg_0_}'
RPROMPT='${vcs_info_msg_1_} %F{cyan}$(date +%H:%M:%S)'
