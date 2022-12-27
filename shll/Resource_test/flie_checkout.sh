#!/bin/bash

PACKAGE_NAME="BYDiLink6.0_JBDkdbdj_4.040"


if [ `echo $PACKAGE_NAME | grep -c "BYDiLink4.0" ` -gt 0 ]; then
    SDK_VER="4.0"
elif [ `echo $PACKAGE_NAME | grep -c "BYDiLink5.0" ` -gt 0 ] || [ `echo $PACKAGE_NAME | grep -c "BYDiLink6.0" ` -gt 0 ] ;then
    SDK_VER="5.0"
else
    echo "Can't know SDK_VER by $PACKAGE_NAME"
    exit 1
fi

echo $SDK_VER
