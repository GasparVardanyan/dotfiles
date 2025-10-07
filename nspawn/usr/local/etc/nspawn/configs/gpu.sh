machinectl bind --mkdir $MACHINE /dev/dri
machinectl bind --mkdir $MACHINE /dev/shm
machinectl bind --mkdir $MACHINE /dev/nvidia0
machinectl bind --mkdir $MACHINE /dev/nvidiactl
machinectl bind --mkdir $MACHINE /dev/nvidia-modeset
machinectl bind --mkdir $MACHINE /dev/nvidia-uvm
machinectl bind --mkdir $MACHINE /dev/nvidia-uvm-tools

systemctl set-property --runtime systemd-nspawn@$MACHINE.service \
	DeviceAllow="/dev/dri/renderD128" \
	DeviceAllow="/dev/dri/renderD129" \
	DeviceAllow="/dev/nvidia0" \
	DeviceAllow="/dev/nvidiactl" \
	DeviceAllow="/dev/nvidia-modeset" \
	DeviceAllow="/dev/nvidia-uvm" \
	DeviceAllow="/dev/nvidia-uvm-tools"
