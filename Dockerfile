FROM python:3

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y build-essential python-dev sudo && pip install uwsgi flask

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]



