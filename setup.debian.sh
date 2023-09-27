#!/bin/bash
# Created by Dan R./Haircutfish
# 2023-09-16
# 
# This bash script is intended to aid in the server
# creation process.  You will need to run this script
# as root and set the following three variables to have the
# script run properly.  To assign the correct Timezone
# here is a Gist with the all Timezones:
# https://gist.github.com/alejzeis/ad5827eb14b5c22109ba652a1a267af5
# Place the Timezone name between the single qoutes.
username=
lm_name=
timezone=''

# Updating the system
apt update && apt upgrade -y

# Installing & setting up Unattended-Upgrades
apt-get install unattended-upgrades apt-listchanges -y
echo unattended-upgrades unattended-upgrades/enable_auto_updates boolean true | debconf-set-selections
dpkg-reconfigure -f noninteractive unattended-upgrades

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
#adduser $username sudo

# Install & setup Fail2Ban
apt install fail2ban -y
apt install ufw -y
ufw allow ssh
ufw allow 22/tcp
ufw enable
fail2ban-client start

# Restarting Server
reboot now
