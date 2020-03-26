export WM=dwm
export TERMINAL=st
export SHELL=zsh
export EDITOR=nvim
export BROWSER=qutebrowser
export PLAN9="/opt/plan9"
#export PATH="$PLAN9/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export CPATH="$HOME/.local/include:$CPATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
export LIBRARY_PATH="$HOME/.local/lib:$LIBRARY_PATH"
export XDG_CONFIG_HOME="$HOME/.config"

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	echo "`cat ~/.local/etc/issue`"
	cp .startx_log .startx_log.old > /dev/null
	startx > ~/.startx_log 2>&1
	logout
fi
