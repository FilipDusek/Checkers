FROM node:9-alpine AS builder

WORKDIR /usr/src/app
COPY ./app/static-src ./app/static-src

WORKDIR /usr/src/app/gulp
COPY ./gulp ./

RUN npm install
RUN npm run gulp copy

FROM python:3

WORKDIR /usr/src/app
RUN apt-get update && apt-get install -y build-essential python-dev sudo && pip install uwsgi flask
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY --from=builder /usr/src/app/app/static/ /usr/src/_temp/

ENTRYPOINT ["/entrypoint.sh"]



