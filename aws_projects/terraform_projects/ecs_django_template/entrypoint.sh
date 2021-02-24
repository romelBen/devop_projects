#!/bin/bash
python manage.py migrate
python manage.py collectstatic --noinput --clear
python manage.py runserver # 0.0.0.0:8000 this will be omitted for production use