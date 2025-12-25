#!/bin/bash -e

echo "Installing Wi-Fi config into /boot/wpa_supplicant.conf"

# use envsubst to substitute variables
envsubst < files/wpa_supplicant.conf.template \
    > "${ROOTFS_DIR}/boot/wpa_supplicant.conf"

chmod 600 "${ROOTFS_DIR}/boot/wpa_supplicant.conf"

