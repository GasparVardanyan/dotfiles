pacman -Ql $(pactree gaspar-meta-fonts -d 1 -l | sed '1d' | paste -s -d ' ') \
	| cut -f 2- -d ' ' \
	| grep -v '/$' \
	| xargs -I _ machinectl bind --mkdir --read-only $MACHINE "_"
