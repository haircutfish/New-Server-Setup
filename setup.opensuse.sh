#!/bin/bash
# Created by Dan R.
# 2023-09-28
# 
# This bash script is intended to aid in the server
# setup process.  You will need to run this script
# as root and set the following four variables to have the
# script run properly.  To assign the correct Timezone
# here is a Gist with the all Timezones:
# https://gist.github.com/alejzeis/ad5827eb14b5c22109ba652a1a267af5
# Place the Timezone name between the single qoutes.
USERNAME=
PASSWORD=
LM_NAME=
TIMEZONE=

if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ] || [ -z "$LM_NAME" ] || [ -z "$TIMEZONE" ]; then
    echo "One or more required variables are empty. Exiting the script."
    exit 1
fi

# Prompts you will receive after running this script:
# install yast2-online-update-configuration
# firewalld


# Updating the system
zypper ref
zypper update -y

# Installing & setting up automatic updates for security
zypper install yast2-online-update-configuration
sed -i 's/AOU_PATCH_CATEGORIES=""/AOU_PATCH_CATEGORIES="security"/g' /etc/sysconfig/automatic_online_update

# Set timezone
timedatectl set-timezone "$TIMEZONE"

# Setting hostname/machine name
hostnamectl set-hostname "$LM_NAME"

# creating a limited user
useradd -m -s /bin/bash "$USERNAME"
echo "$USERNAME":"$PASSWORD" | chpasswd -c SHA256

# If you want the user as a Sudoer, uncomment out the next line
#usermod -aG wheel "$USERNAME"

# Install Firewalld and configure it
zypper install firewalld
systemctl start firewalld
firewall-cmd --set-default-zone=block
firewall-cmd --zone=block --add-port=22/tcp --permanent
firewall-cmd --reload

# Restarting Server
reboot now
