alias prompt-log="_prompt-log-enable && trap '_prompt-log-exec' DEBUG"
function _prompt-log-enable () {
    PS1_SIMPLE=1
    BASH_LOG=${1:-~/demos.out}
    PROMPT_LOG_COLOR=$BLUE
    echo "logging to $BASH_LOG"
    trap '_prompt-log-exec' DEBUG
    #echo "On an older shell, you may need to run \"trap '_prompt_demo_log_command' DEBUG\""
}

_prompt-log-exec () {
        #echo logging $BASH_COMMAND
        # https://superuser.com/questions/175799
        [ -n "$COMP_LINE" ] && return  # do nothing if completing
        [[ "$PROMPT_COMMAND" =~ "$BASH_COMMAND" ]] && return # don't cause a preexec for $PROMPT_COMMAND
        local this_command=`HISTTIMEFORMAT= history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//"`;
        # Here you can add other logging hooks
        echo "$this_command" >> "$BASH_LOG"
        # end
        echo -ne "\e[0m"
}
