#
#tmux_pwd () {
#
#    [ -z "${TMUX}" ] && return
#    # Can't make -t0:0 working, so -tN only for now....
#    #TARGET=$(tmux display-message; tmux show-messages | awk 'END {gsub(/[\[\]]/, "", $6);  split($7, a, ":"); print "-t"$6":"a[1]}')
#    #TARGET=\-t$(tmux display-message -p "#S:#I")
#    TARGET=\-t$(tmux display-message -p "#S")
#    tmux set-window-option ${TARGET} default-path $PWD > /dev/null
#    #
#    # Set default after 5 minutes
#    (( sleep 300; 
#    tmux set-window-option ${TARGET} default-path  ~/Development > /dev/null; ) & ) > /dev/null 2>&1 
#}
#
#alias pwd="\pwd; tmux_pwd"
#
