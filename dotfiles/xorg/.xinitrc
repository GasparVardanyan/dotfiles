#!/bin/sh

[ -f ~/.Xresources ] && xrdb ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi



### autostart ###
numlockx &
~/.fehbg 2>/dev/null &
xcompmgr &
clipmenud &
sxhkd &
setxkbmap -layout "us,am(phonetic-alt)" -option grp:alt_shift_toggle &



### caching ###
find -L ~/media -type f -not -path '*/\.*' >/dev/null &
dmenu_path >/dev/null &
$SHELL -c '' >/dev/null &
[[ $EDITOR = *vim* ]] && $EDITOR +q >/dev/null &



### dwm ###
[ "$WM" == "dwm" ] && while true; do
#	xsetroot -name "| $(date) | $(cat ~/.todo | wc -l) |"
	dwmstatus
	sleep 1
done &



exec $WM
