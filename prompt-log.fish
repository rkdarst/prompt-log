alias prompt-log="_prompt-log-enable"

function _prompt-log-enable;
  set --global PS1_SIMPLE 1;

  if test -n "$argv[1]"
    set --global PROMPT_LOG_FILE "$argv[1]"
  else
    set --global PROMPT_LOG_FILE "$HOME/demos.out";
  end

  # Readlink used to canonicalize filenames (relative paths won't work
  # when cd:ing.)
  if test (uname) = 'Darwin'
    set --global PROMPT_LOG_FILE (greadlink -f "$PROMPT_LOG_FILE")
  else
    set --global PROMPT_LOG_FILE (readlink -f "$PROMPT_LOG_FILE")
  end

  touch "$PROMPT_LOG_FILE"
  #echo setup PROMPT_LOG_FILE: $PROMPT_LOG_FILE ;

  function fish_prompt
    set_color brblue
    echo '$ '
  end

  function preexec_test --on-event fish_preexec
    #echo preexec PROMPT_LOG_FILE: "$PROMPT_LOG_FILE"
    echo "$argv" >> "$PROMPT_LOG_FILE"
    set_color black
  end

  #function postexec_test --on-event fish_postexec
  #  #echo postexec: $argv
  #  #fish_title "$(hostname)   $PWD"
  #  #set hostname (hostname)
  #  #echo -ne "\033]0;$hostname   $PWD\007"
  #end

end


