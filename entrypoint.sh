#! /usr/bin/env bash
mkdir -p /usr/src/app/static/ && cp -r /usr/src/_temp/. /usr/src/app/static/
chown -R 33:33 . && chmod -R g+w .
sudo -u www-data uwsgi --ini uwsgi.ini