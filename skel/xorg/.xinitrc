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



### autostart ###
numlockx &
~/.fehbg 2>/dev/null &
xcompmgr &
clipmenud &
sxhkd &
kbd &


### caching ###
find -L ~/media -type f -not -path '*/\.*' >/dev/null &
dmenu_path >/dev/null &
$SHELL -c '' >/dev/null &
[[ $EDITOR = *vim* ]] && $EDITOR +q >/dev/null &



### todos ###
while :; do todos=$(cat ~/.todo 2>/dev/null | wc -l); [ $todos != 0 ] && dunstify todo "you have $todos todos!"; sleep $(( 60 * 60 )); done &



### feeds ###
(sleep 30; while :; do sfeed_update; sleep $((30 * 60)); done) &



### dwm ###
[ "$WM" == "dwm" ] && while true; do
	# xsetroot -name "| $(pamixer --get-volume-human) | $(free -h | awk '/^Mem:/ {print $3}') | $(date +'[%u] %d.%m.%Y | %T') | *$(cat ~/.todo | wc -l)* |"
	dwmstatus
    sleep 1
done &



exec $WM
