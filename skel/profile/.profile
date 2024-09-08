export WM=dwm
# export WM=icewm-session
export TERMINAL=st
export SHELL=zsh
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=qutebrowser
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

export GIT=127.0.0.1:/srv/git

export PATH="$HOME/.local/share/themes/bin:$HOME/.local/bin:$PATH"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

# export CPATH="$HOME/.local/include:$CPATH"
# export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
# export LIBRARY_PATH="$HOME/.local/lib:$LIBRARY_PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# man colors
# export MANPAGER="less -R --use-color -Dd+r -Du+b"
# export MANROFFOPT="-P -c"
export MANPAGER="nvim +Man!"
# export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
# export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
# export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
# export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
# export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
# export LESS_TERMCAP_us=$'\E[4;32m'     # begin underline
# export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

rm -rf ~/.local/tmp
mkdir ~/.local/tmp
TMPDIR=$HOME/.local/tmp

export SFEED_URL_FILE="$HOME/.sfeed/urls"
[ -f "$SFEED_URL_FILE" ] || touch "$SFEED_URL_FILE"

# export QT_MEDIA_BACKEND=gstreamer
export QT_QPA_PLATFORMTHEME="qt5ct"
# export QT_LOGGING_RULES="*.debug=true;*.*=true;*=true"
export QT_ASSUME_STDERR_HAS_CONSOLE=1

[[ $SHELL = 'zsh' && -f ~/.zshp ]] && source ~/.zshp


if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	# if [ $((($(date +%s) - $(date +%s -r .startx_log.old))/3600)) -ge 6 ]
	# then
		clear
		echo "$(cat $(find ~/.local/etc/banner* | shuf -n 1))"
		sleep 3
	# fi

	cp .startx_log .startx_log.old > /dev/null
	startx > ~/.startx_log 2>&1
	logout
fi
