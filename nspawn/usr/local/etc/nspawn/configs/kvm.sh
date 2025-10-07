machinectl bind --mkdir $MACHINE /dev/kvm
systemctl set-property --runtime systemd-nspawn@$MACHINE.service \
	DeviceAllow="/dev/kvm"
