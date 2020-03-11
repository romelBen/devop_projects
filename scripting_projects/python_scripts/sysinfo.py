#!/usr/bin/env python
import subprocess

def kernal_func():
    uname = "uname"
    uname_arg = "-a"
    print("Gathering system information using %s command: \n") %uname
    subprocess.call([uname, uname_arg])

def disk_func():
    diskspace = "df"
    diskspace_arg = "-h"
    print("Gathering hard disk information using %s command: \n") %diskspace
    subprocess.call([diskspace, diskspace_arg])

# function main which calls both functions
def main():
    kernal_func()
    disk_func()

if __name__ == "__main__":
    main()