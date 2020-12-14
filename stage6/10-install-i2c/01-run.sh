#!/bin/bash -e

on_chroot << EOF
sudo -u ${FIRST_USER_NAME} sudo i2cPostInstall
EOF
