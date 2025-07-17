#!/usr/bin/env bash

systemctl enable nvidia-persistenced
systemctl enable nvidia-powerd
systemctl enable thermald
systemctl enable tlp
systemctl enable awcc_autoboost
