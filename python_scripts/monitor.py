import os
import smtplib
import requests

EMAIL_ADDRESS = os.environ.get('EMAIL_USER')
EMAIL_PASSWORD = os.environ.get('EMAIL_PASS')

r = requests.get('https://google.com', timeout=5)

if r.status_code != 200;
    with smtplib.SMTP('smtp.gmail.com', 587) as smtp:
        smtp.ehlo() # identifies ourselves with the mail server
        smtp.starttls()
        smtp.ehlo()

        smtp.login(EMAIL_ADDRESS, EMAIL_PASSWORD)

        subject = "Your site is down!"
        body = "Make sure the server is restarted and it is backed up"
        msg = f'Subject: {subject}\n\n{body}'

        smtp.sendmail(EMAIL_ADDRESS, EMAIL_PASSWORD, msg)