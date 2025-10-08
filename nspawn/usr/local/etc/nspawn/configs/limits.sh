systemctl set-property --runtime systemd-nspawn@$MACHINE.service	\
	MemoryHigh=10G							\
	MemoryMax=10G							\
	CPUQuota=1000%
