#!/bin/bash -e

echo "Installing Wi-Fi config into /boot/firmware/wpa_supplicant.conf"

# use envsubst to substitute variables
envsubst < files/wpa_supplicant.conf.template \
    > "${ROOTFS_DIR}/boot/firmware/wpa_supplicant.conf"

chmod 600 "${ROOTFS_DIR}/boot/firmware/wpa_supplicant.conf"

