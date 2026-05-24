machinectl bind --mkdir $MACHINE /tmp/.X11-unix
machinectl bind --mkdir --read-only $MACHINE /usr/local/etc/nspawn/profile.d/xorg.sh /etc/profile.d/nspawn_xorg.sh
mkdir -p /tmp/nspawn
chgrp desktop /tmp/nspawn
chmod 777 /tmp/nspawn
machinectl bind --mkdir --read-only $MACHINE /tmp/nspawn
