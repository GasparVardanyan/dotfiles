if [ -d "/usr/local/etc/nspawn/upgrade/$MACHINE" ] ; then
	machinectl bind --mkdir --read-only $MACHINE "/usr/local/etc/nspawn/upgrade/$MACHINE" /tmp/upgrade
fi

