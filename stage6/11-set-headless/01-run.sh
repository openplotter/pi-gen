#!/bin/bash -e

on_chroot << EOF
sed -i 's/#hdmi_force_hotplug=1/hdmi_force_hotplug=1/g' /boot/config.txt
EOF

echo "10.10.10.1		${HOSTNAME}.local ${HOSTNAME}" >> "${ROOTFS_DIR}/etc/hosts"

install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/Network"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/Network/hostapd"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/Network/udev"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/Network/udev/rules.d"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/Network/.openplotter"
install -m 644 -o 1000 -g 1000 files/Network/11-openplotter-usb0.sh	"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/Network/"
install -m 644 files/Network/dhcpcd.conf	"${ROOTFS_DIR}/etc/"
install -m 644 files/Network/dhcpcd.conf	"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/Network/"
install -m 644 files/Network/dnsmasq.conf	"${ROOTFS_DIR}/etc/"
install -m 644 files/Network/dnsmasq.conf	"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/Network/"
install -m 644 -o 1000 -g 1000 files/Network/.openplotter/start-ap-managed-wifi.sh	"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/"
install -m 644 -o 1000 -g 1000 files/Network/.openplotter/start-ap-managed-wifi.sh	"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/Network/.openplotter/"
install -m 644 -o 1000 -g 1000 files/Network/.openplotter/iptables.sh	"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/"
install -m 644 -o 1000 -g 1000 files/Network/.openplotter/iptables.sh	"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/Network/.openplotter/"
install -m 644 -o 1000 -g 1000 files/Network/.openplotter/start1.sh	"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/"
install -m 644 -o 1000 -g 1000 files/Network/.openplotter/start1.sh	"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/Network/.openplotter/"
chmod +x "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/start-ap-managed-wifi.sh"
chmod +x "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/iptables.sh"
chmod +x "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/start1.sh"
install -m 644 files/Network/hostapd/hostapd.conf	"${ROOTFS_DIR}/etc/hostapd/"
install -m 644 files/Network/hostapd/hostapd.conf	"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/Network/hostapd/"
rm -f "${ROOTFS_DIR}/lib/dhcpcd/dhcpcd-hooks/10-wpa_supplicant"
install -m 644 files/Network/10-wpa_supplicant_wlan9	"${ROOTFS_DIR}/lib/dhcpcd/dhcpcd-hooks/"
on_chroot << EOF
echo 'KERNEL=="usb0", SUBSYSTEMS=="net", RUN+="/bin/bash /home/${FIRST_USER_NAME}/.openplotter/Network/11-openplotter-usb0.sh"' > '/etc/udev/rules.d/11-openplotter-usb0.rules'
echo 'KERNEL=="usb0", SUBSYSTEMS=="net", RUN+="/bin/bash /home/${FIRST_USER_NAME}/.openplotter/Network/11-openplotter-usb0.sh"' > '/home/${FIRST_USER_NAME}/.openplotter/Network/udev/rules.d/11-openplotter-usb0.rules'
EOF
install -m 644 files/Network/udev/rules.d/72-wireless.rules	"${ROOTFS_DIR}/etc/udev/rules.d/"
install -m 644 files/Network/udev/rules.d/72-wireless.rules	"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.openplotter/Network/udev/rules.d/"
on_chroot << EOF
systemctl daemon-reload
systemctl unmask hostapd.service
systemctl enable systemd-networkd
systemctl enable dnsmasq
systemctl enable hostapd
systemctl enable vncserver-x11-serviced.service
EOF