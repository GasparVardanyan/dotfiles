#!/usr/bin/env bash

[ ! -f /usr/local/bin/journalfollow ] && exit

s=0

sudo journalfollow | while read l
do
	echo "$l" | grep -Fq 'NVRM: kdispApplyWarForBug3385499_v03_00: timeout waiting for METHOD_EXEC to IDLE' && s=$(( s + 1 ))
	echo "$l" | grep -Fq 'NVRM: kdispApplyWarForBug3385499_v03_00: timeout waiting for channel state to UNCONNECTED' && s=$(( s + 1 ))

	# echo "$s: $l"

	if [ 2 -eq "$s" ]
	then
		s=0
		if xrandr --listactivemonitors | grep -Fq HDMI-1-0
		then
			xrandr --output HDMI-1-0 --mode 1680x1050
			xrandr --output HDMI-1-0 --mode 1920x1080
			[ -x ~/.fehbg ] && ~/.fehbg
			echo "fn" >> /tmp/fn.log
		fi
	fi
done
