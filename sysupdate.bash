#! /bin/bash
## Bring system up to date
apt update
apt -y upgrade
apt -y dist-upgrade
apt -y autoremove
apt -y autoclean
## check if needs restart
if [ -e /var/run/reboot-required ]
then
    echo "**** Restart Required ****"
else
    echo "This update does not require rebooting!"
fi
