machinectl bind --mkdir --read-only $MACHINE /usr/local/etc/nspawn/profile.d/pac.sh /etc/profile.d/nspawn_pac.sh
machinectl bind --mkdir --read-only $MACHINE /usr/local/etc/nspawn/bin/pacrun.sh /usr/bin/pacrun.sh
