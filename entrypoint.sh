#! /usr/bin/env bash
chown -R 33:33 .
sudo -u www-data uwsgi --ini uwsgi.ini