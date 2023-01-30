# Pretty prompt and logging for demos

A "show the recent prompt history for use in demos and teaching".  It
has some features not found in all similar tools:

- Show the command in the history before it exits.  For long running
  commands like those that open the editor, watchers need to see the
  command before it returns back to the shell.
- Also adjust the prompt appearance and color.
- Color the **command being typed** in addition to the prompt itself.
- Updates the window title bar with the machine name and the working
  directory (saving space in the prompt itself).
- Logs to a separate file.  Recommended to open another terminal (with
  a smaller font size) to `tail -f demos.out`.
- Compatible with bash/zsh.  Simple, pure shell.

![demo of prompt-log](img/demo1.png)



## Usage

Installation: Clone the repository, or copy `prompt-log.sh` locally.

`source prompt-log.sh` (this could even be within your shell startup
scripts - the sourceing alone does not change anything).

Then, run the shell alias `prompt-log [file]` to start the logging
(this permanently changes the shell prompt and so on).  Logs are written
to `~/demos.out` if `[file]` not given.



## Status and development

Under semi-active development, but you might expect to have to modify
the source to work on other computers.



## See also

- https://coderefinery.github.io/manuals/instructor-tech-setup/
  lists more things to do for a clear screenshare and lists some other
  options for history logging.
