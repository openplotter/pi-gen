#!/bin/bash -e

on_chroot << EOF
sudo -u ${FIRST_USER_NAME} sudo signalkPostInstall
EOF

#config sk
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.signalk/plugin-config-data"
install -m 644 -o 1000 -g 1000 files/set-system-time.json		"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.signalk/plugin-config-data/"

#install sk plugins
on_chroot << EOF
cd /home/${FIRST_USER_NAME}/.signalk
npm i --verbose signalk-to-nmea2000
chown -R ${FIRST_USER_NAME} /home/${FIRST_USER_NAME}/.signalk
EOF