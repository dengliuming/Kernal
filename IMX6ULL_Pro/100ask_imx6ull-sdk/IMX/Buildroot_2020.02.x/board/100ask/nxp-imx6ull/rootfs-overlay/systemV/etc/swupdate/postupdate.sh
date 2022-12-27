#!/bin/sh
touch /update-ok
sync
wait
echo -e "\033[32m System update ok please wait reboot system ! \033[0m"
reboot
