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

# Updating the system
dnf upgrade -y

# Installing & setting up automatic updates for security
yum install dnf-automatic -y
sed -i 's/upgrade_type = default/upgrade_type = security/g' /etc/dnf/automatic.conf
sed -i 's/apply_updates = no/apply_updates = yes/g' /etc/dnf/automatic.conf

# Set timezone
timedatectl set-timezone "$TIMEZONE"

# Setting hostname/machine name
hostnamectl set-hostname "$LM_NAME"

# creating a limited user
useradd -m -s /bin/bash "$USERNAME"
echo "$USERNAME":"$PASSWORD" | chpasswd -c SHA256

# If you want the user as a Sudoer, uncomment out the next line
#usermod -aG wheel $USERNAME

# Install ufw and configure it
yum install ufw -y
ufw allow 22
ufw enable

# Restarting Server
reboot now
