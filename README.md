# Pretty prompt and logging for demos

A "show the recent prompt history for use in demos and teaching".  It
has some features not found in all similar tools:

- Show the command before it exits (this is sometimes missing for
  long-running commands, like `git commit` that invokes an editor)
- Color the **command being typed** more strongly than the prompt
  itself.
- Simple, pure bash.

![demo of prompt-log](img/demo1.png)


## Usage

Right now this only supports bash.

`source prompt-log.sh` (this could even be within your shell startup
scripts)

This creates a shell alias `prompt-log [file]` to start the logging
(it permanently changes the shell prompt and so on).  Logs are written
to `~/demos.out` if `[file]` not given.


## Status and development

Under semi-active development, but right now it is a little bit too
focused on only rkdarst's computers, so it may require work to
generalize for others to use.


## See also

- https://coderefinery.org/manuals/instructor-tech-setup/#terminal-history-for-learners
  lists some other options
