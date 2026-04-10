machinectl bind --mkdir $MACHINE /dev/dri
machinectl bind --mkdir $MACHINE /dev/shm

systemctl set-property --runtime systemd-nspawn@$MACHINE.service \
	DeviceAllow="/dev/dri/renderD128" \
	DeviceAllow="/dev/dri/card1" \
