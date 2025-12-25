#!/bin/bash -e

echo "Create wirepas folder on boot"
install -v -d "${ROOTFS_DIR}/boot/firmware/nu"

echo "Move ENV files into boot/firmware/nu folder"
install -m 755 templates/* "${ROOTFS_DIR}/boot/firmware/nu/"

echo "Add docker compose to home folder"
install -m 755 files/docker-compose.yml	"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/"

echo "Add systemd service to start Gateway at boot time"
install -m 644 files/wirepasGatewayUpdate.service	"${ROOTFS_DIR}/etc/systemd/system/"

echo "Add systemd service to configure sink at boot time"
install -m 644 files/wirepasSinkConfigurator.service	"${ROOTFS_DIR}/etc/systemd/system/"

echo "Add mosquitto config to accept ws connection"
install -m 644 files/config_ws_tcp.conf	"${ROOTFS_DIR}/etc/mosquitto/conf.d/"

echo "Execute install script"
on_chroot << EOF
systemctl enable wirepasGatewayUpdate.service

systemctl enable wirepasSinkConfigurator.service

# Download all images to speed up first boot and generate tar file out of it
cd /home/${FIRST_USER_NAME}

docker pull wirepas/gateway_transport_service:latest
docker save wirepas/gateway_transport_service:latest -o transport_service.tar

docker pull wirepas/gateway_sink_service:latest
docker save wirepas/gateway_sink_service:latest -o sink_service.tar

docker pull wirepas/gateway_dbus_service:latest
docker save wirepas/gateway_dbus_service:latest -o dbus_service.tar

EOF
