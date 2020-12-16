# operating file for read and write
s=open("file.txt", "a")
s.write("this is a test\n")
s.close()
read_file=open("file.txt", "r").read()
print(read_file)