#!/bin/sh

[ -f ~/.Xresources ] && xrdb ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

numlockx &
~/.fehbg 2>/dev/null &
xcompmgr &
clipmenud &
sxhkd &
setxkbmap -layout "us,am(phonetic-alt)" -option grp:alt_shift_toggle &

# caching
find -L ~ -type f -not -path '*/\.*' >/dev/null &
dmenu_path >/dev/null &

# (echo -e '# define CONF_WM WM_DWM\n# define CONF_COLORS\n# define CONF_COLORFUL\n# define CONF_NOTES' ; cat .local/share/statusbar) | cpp | bash &

while true; do
#	xsetroot -name "| $(date) | $(cat ~/.todo | wc -l) |"
	dwmstatus
	sleep 1
done &

exec dwm
