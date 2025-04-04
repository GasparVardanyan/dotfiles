#!/bin/sh

[ -f ~/.Xresources ] && xrdb ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi



# virtualbox
vbox=$(dmesg |grep -io virtualbox)
if [ ! -z "$vbox" ]
then
  /usr/bin/VBoxClient --seamless
  /usr/bin/VBoxClient --clipboard
  /usr/bin/VBoxClient --vmsvga
fi



# run first without -delete to be sure
mkdir -p ~/.cache/thumbnails/mpv-gallery
find ~/.cache/thumbnails/mpv-gallery/ -maxdepth 1 -type f -amin +$((7 * 60 * 24)) -delete

if [ "$WM" == "dwm" ]
then
	### autostart ###
	numlockx &
	xcompmgr &
	clipmenud &
	flameshot &
	kbd &
	(sleep 1; setxkbmap -option caps:none) &
	syncthing serve --no-browser &
	# (sleep 2; xrandr --output DP1 --off; xrandr --output DP1 --mode 1366x768 --right-of eDP1; ~/.fehbg 2>/dev/null) &
	~/.fehbg 2>/dev/null &



	(
		sleep 2
		# turn off Display Power Management Service (DPMS)
		xset -dpms
		# turn off black Screensaver
		xset s off
	) &



	### caching ###
	#find -L ~/media -type f -not -path '*/\.*' >/dev/null &
	dmenu_path >/dev/null &
	$SHELL -c '' >/dev/null &
	[[ $EDITOR = *vim* ]] && $EDITOR +q >/dev/null &



	### waiting for pinetab-v ###
	# (sleep 30; while :; do [[ 0 = $(curl 'https://pine64.com/product/pinetab-v-10-1-8gb-128gb-risc-v-based-linux-tablet-with-detached-backlit-keyboard/' | grep '<p class="stock out-of-stock">Out of stock</p>' | wc -l) ]] && dunstify 'PineTab-V is ready'; sleep $((30 * 60)); done) &



	### waiting for ideapad ###
	# (sleep 30; while :; do [[ 0 = $(curl 'https://mtech.am/en_us/products/lenovo-ideapad-pro-5-14imh9-%2883d20024rk%29' | grep 'Out of Stock' | wc -l) ]] && dunstify 'Ideapad is Ready'; sleep $((30 * 60)); done) &

	### waiting for ideapad price change ###
	(sleep 30; while :; do c=$(curl 'https://mtech.am/en_us/products/lenovo-ideapad-pro-5-14imh9-%2883d20027rk%29' 2>/dev/null | paste -s -d ' ' | rg '<h5\s+class="price">\s+<strong>Price:</strong>\s+<span\s+class="price-amount">\s+629.900\s+AMD\s+</span>\s+</h5>' | wc -l); [ 1 -ne $c ] && dunstify 'Ideapad Price Changed'; sleep $((30 * 60)); done) &



	### todos ###
	while :; do todos=$(cat ~/.todo 2>/dev/null | wc -l); [ $todos != 0 ] && dunstify todo "you have $todos todos!"; sleep $(( 3 * 60 * 60 )); done &



	### feeds ###
	(sleep 30; while :; do touch ~/.local/tmp/sfu; sfeed_update; rm ~/.local/tmp/sfu; sleep $((30 * 60)); done) &






	### battery ###
	(while :; do
		batp="$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | sed '/ignored/d' | grep percentage | sed 's/[[:space:]]\+.*[[:space:]]\+//;s/%//')"
		bat_status="$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep state | sed 's/[[:space:]]\+.*[[:space:]]\+//')"

		if [[ $batp -le 20 ]] ; then
			if [[ $bat_status != 'charging' ]] ; then
				dunstify Battery "Remaining $batp%"
			fi
		fi
	sleep $((5 * 60)); done) &

	(
	sleep 3
	xrandr --output DP-1 --mode 1920x1080 --right-of eDP-1
	xrandr --output HDMI-1 --mode 1920x1080 --left-of eDP-1
	sleep 1

	# while :; do find ~/.local/share/wallpapers/sw -type f | shuf -n 3 | paste -s -d ' ' | xargs feh --no-fehbg --bg-fill; sleep 300; done
	./.fehbg
	) &

	### dwm ###
	[ "$WM" == "dwm" ] && while true; do
		# xsetroot -name "| $(pamixer --get-volume-human) | $(free -h | awk '/^Mem:/ {print $3}') | $(date +'[%u] %d.%m.%Y | %T') | *$(cat ~/.todo | wc -l)* |"
		dwmstatus
		sleep 1
	done &
fi



exec $WM
