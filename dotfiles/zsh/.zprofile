export TERMINAL=urxvt
export EDITOR=nvim
export BROWSER=qutebrowser
export PATH="$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

echo "`cat ~/.local/etc/issue`"

cp .startx_log .startx_log.old > /dev/null
startx > ~/.startx_log 2>&1
logout
