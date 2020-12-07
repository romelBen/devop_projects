import os

# Creation of the LVM in the Linux terminal
disk1=input("Enter first disk name: ")
volume=input("Enter the name of the volume group: ")
name=input("Enter the name of the LVM: ")
size=input("Enter the size of the LVM: ")
mount_point=input("Input the LVM mountpoint name: ")

# Create the PV
os.system("pvcreate /dev/"+disk1)

# Create the Volume Group
os.system("vgcreate "+volume+" /dev/"+disk1)
os.system("vgdisplay "+volume)

# Create LVM usinf lvcreate
os.system("lvcreate --size +"+size+"G --name "+name+" "+volume)

# Formatting the lvm to use the lvm
os.system("mkfs.ext4 /dev/"+volume+"/"+name)

# Mount
os.system("mkdir /"+mount_point)
os.system("mount /dev/"+volume+"/"+name)
os.system("cd /"+mount_point)