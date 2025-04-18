# history

> Command-line history.
> More information: <https://www.gnu.org/software/bash/manual/html_node/Bash-History-Builtins.html#index-history>.

- Display the commands history list with line numbers:

`history`

- Display the last 20 commands (in Zsh it displays all commands starting from the 20th):

`history {{20}}`

- Display history with timestamps in different formats (only available in Zsh):

`history -{{d|f|i|E}}`

- [c]lear the commands history list (only for current Bash shell):

`history -c`

- Over[w]rite history file with history of current Bash shell (often combined with `history -c` to purge history):

`history -w`

- [d]elete the history entry at the specified offset:

`history -d {{offset}}`
