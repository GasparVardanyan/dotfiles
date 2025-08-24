pacman -Ql ttf-iosevka-nerd \
	| cut -f 2 -d ' ' \
	| grep -v '/$' \
	| xargs -L 1 machinectl bind --mkdir --read-only $MACHINE
