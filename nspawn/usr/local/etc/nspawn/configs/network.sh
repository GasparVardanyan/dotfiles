machinectl bind --mkdir --read-only $MACHINE /etc/hosts
machinectl bind --mkdir --read-only $MACHINE /etc/profile.d/proxy.sh
machinectl bind --mkdir --read-only $MACHINE /etc/bash.bashrc
machinectl bind --mkdir --read-only $MACHINE /usr/local/etc/nspawn/bin/pacrun.sh /usr/bin/pacrun.sh
