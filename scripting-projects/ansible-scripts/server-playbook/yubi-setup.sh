#! /bin/bash

## Script will add in a yubico key to your server which will REQUIRE your password
## AND the yubico key once it has been setup.
# Setup Yubikey by creating a directory and adding your yubico key for MFA Authentication
mkdir -p ~/.config/Yubico
pamu2fcfg > ~/.config/Yubico/u2f_keys

## ONLY include if you have a backup yubico key. Plug the 2nd Yubico key and the below line will
## upload the 2nd Yubico key for redundancy.
#pamu2fcfg -n >> ~/.config/Yubico/u2f_keys

# Require Yubikey to enter the Linux system
sudo nano /etc/pam.d/sudo
sudo sed -i '5 aauth\t required\t pam_u2f.so' /etc/pam.d/sudo

# Configure the login manager known as Gnome Display Manager (GDM) to futher protect your system.
sudo sed -i '4 aauth\t required\t pam_u2f.so' /etc/pam.d/gdm-password

# Futher protection to TTY if your laptop/desktop is to be broken
sudo sed -i '57 aauth\t required\t pam_u2f.so' /etc/pam.d/login