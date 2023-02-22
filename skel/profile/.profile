export WM=dwm
export TERMINAL=st
export SHELL=zsh
export EDITOR=nvim
export BROWSER=qutebrowser
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"

export PATH="$HOME/.local/share/themes/bin:$HOME/.local/bin:$PATH"

export CPATH="$HOME/.local/include:$CPATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
export LIBRARY_PATH="$HOME/.local/lib:$LIBRARY_PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# man colors
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[4;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

rm -rf ~/.local/tmp
mkdir ~/.local/tmp
TMPDIR=$HOME/.local/tmp

export SFEED_URL_FILE="$HOME/.sfeed/urls"
[ -f "$SFEED_URL_FILE" ] || touch "$SFEED_URL_FILE"

export QT_QPA_PLATFORMTHEME="qt5ct"

[[ $SHELL = 'zsh' && -f ~/.zshp ]] && source ~/.zshp


if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	if [ $((($(date +%s) - $(date +%s -r .startx_log.old))/3600)) -ge 6 ]
	then
	    echo "$(cat ~/.local/etc/issue)"
	    sleep 3
	fi

	cp .startx_log .startx_log.old > /dev/null
	startx > ~/.startx_log 2>&1
	logout
fi
