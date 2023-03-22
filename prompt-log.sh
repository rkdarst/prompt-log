if [[ $(uname) == 'Darwin' ]]; then
  READLINK=greadlink
else
  READLINK=readlink
fi

if [ -n "$ZSH_NAME" ] ; then
    #zsh
    #alias prompt-log="_prompt-log-enable && preexec() { echo -ne $'\e[0m' ; _prompt-log-exec }"
    alias prompt-log="_prompt-log-enable"
else
    # bash
    # Setting `trap` in a function doesn't work on some versions of bash,
    # this is more reliable.
    alias prompt-log="trap '_prompt-log-exec-bash' DEBUG && _prompt-log-enable"
    #echo "On an older shell, you may need to run \"trap '_prompt_demo_log_command' DEBUG\""
fi
# This does initial setup.
function _prompt-log-enable () {
    PS1_SIMPLE=1
    PROMPT_LOG_FILE=$($READLINK -f ${1:-~/demos.out})
    PROMPT_LOG_COLOR=${PROMPT_LOG_COLOR:-$BLUE}
    PROMPT_LOG_COLOR_CMD=${PROMPT_LOG_COLOR_CMD:-$LIGHT_BLUE}
    if [ -n "$ZSH_NAME" ] ; then
	# zsh
	export PS1=$'%~%#\e[0m %B%F{blue}'
	preexec() { echo -ne $'\e[0m' ; echo "$1" >> "$PROMPT_LOG_FILE" ; }
    else
	# bash
        # With path
	#export PS1="$PROMPT_LOG_COLOR\w\$$NO_COLOR $PROMPT_LOG_COLOR_CMD"
        # Without path
	export PS1="$PROMPT_LOG_COLOR\$$NO_COLOR $PROMPT_LOG_COLOR_CMD"
	#trap '_prompt-log-exec-bash' DEBUG
    fi
    echo "logging to $PROMPT_LOG_FILE"

    # Set prompt command to display terminal title.
    PROMPT_COMMAND='chtitle "$(hostname)   $PWD"'
}

# Change the terminal emulator title.
function chtitle () {
    echo -ne "\033]0;$*\007" ; BASH_CUSTOMTITLE=t
}

# This is run on each prompt, finds `this_command` and handles it.
_prompt-log-exec-bash () {
    if [ -z "$PROMPT_LOG_FILE" ] ; then
	return
    fi
    #echo logging $BASH_COMMAND
    # https://superuser.com/questions/175799
    [ -n "$COMP_LINE" ] && return  # do nothing if completing
    [[ "$PROMPT_COMMAND" =~ "$BASH_COMMAND" ]] && return # don't cause a preexec for $PROMPT_COMMAND
    local this_command=`HISTTIMEFORMAT= history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//"`;
    # Here you can add other logging hooks
    echo "$this_command" >> "$PROMPT_LOG_FILE"
    # end
    echo -ne "\e[0m" # Reset color to neutral
}

BLACK="\[\e[0;30m\]"
BLUE="\[\e[0;34m\]"
GREEN="\[\e[0;32m\]"
CYAN="\[\e[0;36m\]"
RED="\[\e[0;31m\]"
PURPLE="\[\e[0;35m\]"
BROWN="\[\e[0;33m\]"
LIGHT_GRAY="\[\e[0;37m\]"
DARK_GRAY="\[\e[1;30m\]"
LIGHT_BLUE="\[\e[1;34m\]"
LIGHT_GREEN="\[\e[1;32m\]"
LIGHT_CYAN="\[\e[1;36m\]"
LIGHT_RED="\[\e[1;31m\]"
LIGHT_PURPLE="\[\e[1;35m\]"
YELLOW="\[\e[1;33m\]"
WHITE="\[\e[1;37m\]"
NO_COLOR="\[\e[0m\]"
