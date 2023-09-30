#!/bin/bash
# Created by Dan R.
# 2023-09-28
# 
# This bash script is intended to aid in the server
# setup process.  You will need to run this script
# as root and set the following three variables to have the
# script run properly.  To assign the correct Timezone
# here is a Gist with the all Timezones:
# https://gist.github.com/alejzeis/ad5827eb14b5c22109ba652a1a267af5
# Place the Timezone name between the single qoutes.
username=
lm_name=
timezone=''

# Prompts you will receive after running this script:
# install yast2-online-update-configuration
# fail2ban
# firewalld


# Updating the system
zypper ref
zypper update -y

# Installing & setting up automatic updates for security
zypper install yast2-online-update-configuration
sed -i 's/AOU_PATCH_CATEGORIES=""/AOU_PATCH_CATEGORIES="security"/g' /etc/sysconfig/automatic_online_update

# Set timezone
timedatectl set-timezone $timezone

# Setting hostname/machine name
hostnamectl set-hostname $lm_name

# creating a limited user
useradd -m -s /bin/bash -p password $username
echo $username:password | chpasswd

# Sets password as expired, so that it gets changed upon login
passwd -e $username

# If you want the user as a Sudoer, uncomment out the next line
usermod -aG wheel $username

# Install & setup Fail2Ban and firewall
zypper install fail2ban -y
zypper install firewalld
systemctl start firewalld
firewall-cmd --set-default-zone=block
firewall-cmd --zone=block --add-port=22/tcp --permanent
firewall-cmd --reload
systemctl enable --now fail2ban

# Restarting Server
reboot now