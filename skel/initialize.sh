#!/usr/bin/env bash

mkdir -p ~/.config ~/.local ~/.local/share ~/.local/etc ~/.cache

pushd /desktop/dotfiles/skel

	ln -sfv $PWD/alacritty/.config/alacritty ~/.config
	ln -sfv $PWD/alsa/.asoundrc ~
	ln -sfv $PWD/bat/.config/bat ~/.config
	ln -sfv $PWD/feh/.fehbg ~
	ln -sfv $PWD/git/.gitconfig ~
	ln -sfv $PWD/mpv/.config/mpv ~/.config
	ln -sfv $PWD/profile/.profile ~
	ln -sfv $PWD/zsh/.zshrc ~
	ln -sfv ~/.{,z}profile
	ln -sfv $PWD/zsh/.zsh.d ~
	mkdir -pv ~/.config/cmus
	ln -sfv $PWD/cmus/.config/cmus/rc ~/.config/cmus
	ln -sfv $PWD/sxiv/.config/sxiv ~/.config
	rm -fv ~/.config/nsxiv
	ln -sfv ~/.config/{,n}sxiv
	ln -sfv $PWD/tmux/.tmux.conf ~
	mkdir -pv ~/.local/etc # TODO: move theming to /desktop
	ln -sfv $PWD/xorg/.local/etc/theme ~/.local/etc
	ln -sfv $PWD/xorg/.local/etc/theme.defaults ~/.local/etc
	ln -sfv $PWD/xorg/.config/mimeapps.list ~/.config
	ln -sfv $PWD/xorg/.xinitrc ~
	ln -sfv $PWD/xorg/.Xresources ~
	ln -sfv ~/.X{resources,defaults}
	ln -sfv $PWD/dunst/.config/dunst ~/.config
	mkdir -pv ~/.gnupg
	ln -sfv $PWD/gnupg/.gnupg/pinentry-dmenu.conf ~/.gnupg
	mkdir -pv ~/.local/etc
	ln -sfv $PWD/issue/.local/etc/issue ~/.local/etc
	ln -sfv $PWD/issue/.local/etc/banner ~/.local/etc
	ln -sfv $PWD/qt5ct/.config/qt5ct ~/.config
	mkdir -pv ~/.sfeed
	ln -sfv $PWD/sfeed/.sfeed/sfeedrc ~/.sfeed
	ln -sfv $PWD/banners/.local/etc/banner* ~/.local/etc
	rm -fv ~/.local/etc/banner.{angel,women}
	ln -sfv $PWD/lazygit/.config/lazygit ~/.config
	ln -sfv $PWD/ripgrep/.ripgreprc ~
	ln -sfv $PWD/flameshot/.config/flameshot ~/.config
	ln -sfv $PWD/profanity/.config/profanity ~/.config

	mkdir -pv ~/.config/qutebrowser
	ln -sfv $PWD/qutebrowser/.config/qutebrowser/config.py ~/.config/qutebrowser
	ln -sfv $PWD/qutebrowser/.config/qutebrowser/quickmarks ~/.config/qutebrowser
	ln -sfv $PWD/qutebrowser/.config/qutebrowser/themes ~/.config/qutebrowser
	ln -sfv $PWD/qutebrowser/.config/qutebrowser/solarized-everything-css ~/.config/qutebrowser

	mkdir -pv ~/.local/share/qutebrowser
	ln -sfv $PWD/qutebrowser/.local/share/qutebrowser/greasemonkey ~/.local/share/qutebrowser

	echo -ne "\ng\nw\n" | while read D
	do
		qDir=~/.local/share/scratchqb"$D"
		mkdir -pv "$qDir"
		ln -sfv ~/.config/qutebrowser "$qDir"/config
		mkdir -pv "$qDir"/data
		rm -fv "$qDir"/data/greasemonkey
		ln -sfv ~/.local/share/qutebrowser/greasemonkey "$qDir"/data
	done

	rm -fv /desktop/utilsbin
	ln -sfv $PWD/utilsbin/.local/bin /desktop/utilsbin
	rm -fv ~/.local/share/themes
	ln -sfv /desktop/themes ~/.local/share
	rm -fv ~/.local/share/wallpapers
	ln -sfv /desktop/wallpapers ~/.local/share

	mkdir -pv ~/.local/share/icons
	ln -sfv /desktop/dotfiles/themes/cursor-themes/.local/share/icons/Maya-Red24 ~/.local/share/icons
	ln -sfv /desktop/dotfiles/themes/cursor-themes/.local/share/icons/Red-Dot ~/.local/share/icons
	ln -sfv /desktop/dotfiles/themes/icon-themes/.local/share/icons/Solarized-Deluxe-Iconpack ~/.local/share/icons

popd

pushd /desktop/dotfiles/cachedots

	rm -fv ~/.cache/cppman
	ln -sfv $PWD/cppman/.cache/cppman ~/.cache
	rm -fv ~/.cache/tldr
	ln -sfv $PWD/tealdeer/.cache/tealdeer ~/.cache

popd
