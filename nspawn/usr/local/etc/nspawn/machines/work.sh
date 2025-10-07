#!/usr/bin/env bash

MACHINE=work

systemctl set-property --runtime systemd-nspawn@$MACHINE.service MemoryHigh=10G MemoryMax=10G CPUQuota=1000%

source /usr/local/etc/nspawn/configs/mirrorlist.sh
source /usr/local/etc/nspawn/configs/upgrade.sh
source /usr/local/etc/nspawn/configs/desktop.sh
source /usr/local/etc/nspawn/configs/font.sh
source /usr/local/etc/nspawn/configs/gpu.sh
source /usr/local/etc/nspawn/configs/xorg.sh

source /usr/local/etc/nspawn/configs/userconfig.sh
