#!/usr/bin/env bash

MACHINE="$1"
CONF="/usr/local/etc/nspawn/machines/$MACHINE.sh"

if [ -f "$CONF" ] ; then
	source "$CONF"
fi

source /usr/local/etc/nspawn/configpacks/essentials.sh
