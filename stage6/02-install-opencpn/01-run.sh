#!/bin/bash -e

install -m 644 files/opencpn.desktop	"${ROOTFS_DIR}/usr/share/applications/"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.opencpn"
# update plugin catalogue
# enable dashboard, grib
# signal k connection
install -m 644 -o 1000 -g 1000 files/opencpn.conf		"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.opencpn/"
