#!/usr/bin/env bash

CALLER_USER="${SUDO_USER:-$USER}"

uid=$(id -u "$CALLER_USER")
msg="$@"
sudo -u "$CALLER_USER" DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$uid/bus" \
dunstify $@
