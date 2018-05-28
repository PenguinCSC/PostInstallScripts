#! /bin/bash

# Identify the distro and continues the installation accordingly

# Identify Distro

case `lsb_release -sc` in

        xenial)
                echo "You are running Xenial"
                ;;
        bionic)
                echo "You are running Bionic"
                ;;
esac
