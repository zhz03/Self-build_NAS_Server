sudo apt-get update 
# to upgrade the system 
sudo apt-get upgrade
# to add support for ntfs formatted drive
sudo apt-get install ntfs-3g
# to add support for exfat formatted drive
sudo apt-get install exfat-utils exfat-fuse
# samba sever on raspberry pi
## chose "yes" during the installation
sudo apt-get install samba samba-common-bin
# 
sudo mkdir /PiServer
sudo chmod 777 /PiServer
# to see connected drive
lsblk
# if your hhd drive isn't mounted to your raspberry
sudo mount /dev/sda1 /PiServer
# to check it 
lsblk 
# to configure samba
sudo nano /etc/samba/smb.conf

### add the following lines to the bottom of smb.conf
# [Raspberry Pi 4_01 Nas Server]
# comment = "Pi4-01"
# Path = /PiServer
# read only = no
# writeable = yes
# browseable = yes
# create mask = 0777
# directory mask = 0777
# public = no
# force user = root
### ctrl + x to exit and yes to save

# add user to communicate with Raspberry pi NAS
sudo adduser zhaoliang
## create your user password

# set a samba password for this user
sudo smbpasswd -a zhaoliang
## Note user password use to login into Raspberry Pi Via SSH and Samba Password used to login into NAS server
## create your user password, you can keep it same as your user password

# restart samba server
sudo /etc/init.d/smbd restart
sudo /etc/init.d/nmbd restart

# once your restart raspberry pi, your mounted HHD will be unknown automatically
# type the following commands to prevent this issue
sudo nano /etc/fstab
### add the following code to the bottom of that file
# /dev/sda1 /PiServer auto defaults, user 0 2

# often times when reboot raspberry pi, the IP address will keep on changing
# set static address for raspberry pi
sudo nano /etc/dhcpcd.conf
### to set static ip address for raspberry pi 4
### add the following code to the bottom of that file 
# static ip_address=192.168.0.16 #you can set any ip address between 192.168.0.2-192.168.0.23
# static routers=192.168.0.1
# static domain_name_servers=192.168.0.1
### save the changes by ctrl+x and yes

# reboot the system
sudo reboot

