#!/bin/sh -e

echo "start myir HMI 2.0..."

export QT_QPA_EGLFS_ALWAYS_SET_MODE="1"
export QT_QPA_EGLFS_KMS_ATOMIC='1'
export QT_QPA_EGLFS_KMS_CONFIG='/usr/share/qt5/cursor.json'

psplash-drm-quit
export QT_QPA_PLATFORM='eglfs'
/usr/bin/mxapp2  -platform eglfs &

#export QT_QPA_PLATFORM='linuxfb'
#/home/mxapp2 -platform linuxfb &
wait
exit 0

