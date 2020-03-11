import paramiko, smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
p = paramiko.SSHClient()
cred = open("cred.csv","r")
for i in cred.readlines():
    try:
        line=i.strip()
        ls=line.split(",")
        print(ls)
        msg=MIMEMultipart('alternative')
        msg['Subject'] = 'Test Mail'
        From = email here
        To = email here
        Cc = carbon copy here
        txt = "Info Collector"
        data = open("%s.txt"%ls[0], "r").read()
        s=smtplib.SMTP('smtp.gmail.com', 587) #port for gmail
        s.ehlo()
        s.starttls()
        gmail_cred = open("gmail_cred.txt", "r").read().split(",")
        s.login(gmail_cred[0], gmail_cred[1])
        s.sendmail(From, To, msg.as_string())
        s.quit()
    except Exception as error:
        print(error)
cred.close()