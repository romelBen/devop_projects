FROM python:3.8.5-slim-buster

WORKDIR /app

COPY Pipfile Pipfile.lock ./

RUN pip install pipenv && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc postgresql \
    python3-dev \
    libssl-dev \
    && \
    pipenv install

RUN pipenv lock --requirements > requirements.txt
RUN pip install -r requirements.txt

COPY project ./project
COPY entrypoint.sh manage.py .env ./

ENTRYPOINT [ "/app/entrypoint.sh" ]