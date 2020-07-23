export WM=dwm
export TERMINAL=st
export SHELL=zsh
export EDITOR=nvim
export BROWSER=qutebrowser

export PATH="$HOME/.local/bin:$PATH"

export CPATH="$HOME/.local/include:$CPATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
export LIBRARY_PATH="$HOME/.local/lib:$LIBRARY_PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	echo "`cat ~/.local/etc/issue`"
	cp .startx_log .startx_log.old > /dev/null
	startx > ~/.startx_log 2>&1
	logout
fi
