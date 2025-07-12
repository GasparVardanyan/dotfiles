#!/bin/sh

# xrandr --setprovideroutputsource modesetting NVIDIA-G0
# xrandr --auto

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

[ -f ~/.Xresources ] && xrdb ~/.Xresources &

mkdir -p ~/.cache/thumbnails/mpv-gallery
find ~/.cache/thumbnails/mpv-gallery/ -maxdepth 1 -type f -amin +$((7 * 60 * 24)) -delete

if [ "$WM" == "dwm" ]
then
	### autostart ###
	numlockx &
	# xcompmgr &
	picom -b --backend glx --vsync -c &
	clipmenud &
	flameshot &
	kbd &
	syncthing serve --no-browser &
	~/.fehbg 2>/dev/null &
	ytmpv_server.py &
	# conky &



	### caching ###
	#find -L ~/media -type f -not -path '*/\.*' >/dev/null &
	dmenu_path >/dev/null &



	### waiting for pinetab-v ###
	# (sleep 30; while :; do [[ 0 = $(curl 'https://pine64.com/product/pinetab-v-10-1-8gb-128gb-risc-v-based-linux-tablet-with-detached-backlit-keyboard/' | grep '<p class="stock out-of-stock">Out of stock</p>' | wc -l) ]] && dunstify 'PineTab-V is ready'; sleep $((30 * 60)); done) &



	### waiting for ideapad ###
	# (sleep 30; while :; do [[ 0 = $(curl 'https://mtech.am/en_us/products/lenovo-ideapad-pro-5-14imh9-%2883d20024rk%29' | grep 'Out of Stock' | wc -l) ]] && dunstify 'Ideapad is Ready'; sleep $((30 * 60)); done) &

	### waiting for ideapad price change ###
	# (sleep 30; while :; do c=$(curl 'https://mtech.am/en_us/products/lenovo-ideapad-pro-5-14imh9-%2883d20027rk%29' 2>/dev/null | paste -s -d ' ' | rg '<h5\s+class="price">\s+<strong>Price:</strong>\s+<span\s+class="price-amount">\s+629.900\s+AMD\s+</span>\s+</h5>' | wc -l); [ 1 -ne $c ] && dunstify 'Ideapad Price Changed'; sleep $((30 * 60)); done) &



	### todos ###
	while :; do todos=$(cat ~/.todo 2>/dev/null | wc -l); [ $todos != 0 ] && dunstify todo "you have $todos todos!"; sleep $(( 3 * 60 * 60 )); done &



	### feeds ###
	(sleep 30; while :; do touch ~/.local/tmp/sfu; sfeed_update; rm ~/.local/tmp/sfu; sleep $((30 * 60)); done) &



	### battery ###
	(while :; do
		batinf=$(acpi | head -n 1 | cut -d : -f 2 | tr -d ' ' | tr '[:upper:]' '[:lower:]')
		batp=$(echo "$batinf" | cut -d , -f 2 | cut -f 1 -d %)
		bat_status=$(echo "$batinf" | cut -d , -f 1)

		if [[ $batp -le 20 ]] ; then
			if [[ $bat_status != 'charging' ]] ; then
				dunstify Battery "Remaining $batp%"
			fi
		fi
	sleep $((5 * 60)); done) &

	(
		xrandr --output eDP-1 --mode 2560x1600 --rate 60
		sleep 2
		# xrandr --output eDP-1 --mode 1920x1200

		# turn off Display Power Management Service (DPMS)
		xset -dpms
		# turn off black Screensaver
		xset s off
		# disable caps lock
		setxkbmap -option caps:none

		# xrandr --output DP-1 --mode 1920x1080 --right-of eDP-1
		xrandr --output HDMI-1-0 --mode 1920x1080 --left-of eDP-1
		# xrandr --output HDMI-0 --mode 1920x1080 --left-of eDP-1-1
		sleep 1

		# while :; do find ~/.local/share/wallpapers/sw -type f | shuf -n 3 | paste -s -d ' ' | xargs feh --no-fehbg --bg-fill; sleep 300; done
		./.fehbg
	) &
fi

### dwm ###
[ "$WM" == "dwm" ] && while true; do
	# xsetroot -name "| $(pamixer --get-volume-human) | $(free -h | awk '/^Mem:/ {print $3}') | $(date +'[%u] %d.%m.%Y | %T') | *$(cat ~/.todo | wc -l)* |"
	dwmstatus
	sleep 1
done &



exec $WM
