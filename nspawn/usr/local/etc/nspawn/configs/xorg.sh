machinectl bind --mkdir $MACHINE /tmp/.X11-unix
mkdir /tmp/nspawn
chmod +rwx /tmp/nspawn
machinectl bind --mkdir --read-only $MACHINE /tmp/nspawn
