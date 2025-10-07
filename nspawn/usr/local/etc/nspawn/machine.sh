#!/usr/bin/env bash

CONF="/usr/local/etc/nspawn/machines/$1.sh"

if [ -f "$CONF" ] ; then
	source "$CONF"
fi
