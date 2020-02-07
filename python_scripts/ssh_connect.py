import paramiko

p = paramiko.SSHClient()
p.set_missing_host_key_policy(paramiko.AutoAddPolicy())
p.connect("192.168.15.173", port=22, username="romel.benavides", password="password")
stdin, stdout, stderr = p.exec_command("cat /etc/fstab") #any command will show what is present
opt = stdout.readlines()
opt = "".join(opt)
print(opt)