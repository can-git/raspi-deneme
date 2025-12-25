#!/bin/bash -e

echo "Installing Wi-Fi config into /boot/firmware/wpa_supplicant.conf"
install -m 644 files/wpa_supplicant.conf.template	"${ROOTFS_DIR}/etc/wpa_supplicant/"
