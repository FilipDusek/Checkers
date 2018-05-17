# Import base image for build stage with Node installed
FROM node:9-alpine AS builder

# Copy build scripts and source data to be built
WORKDIR /usr/src/app/gulp
COPY ./gulp ./
COPY ./app/static-src ../app/static-src

# Install dependencies for build script and run it
RUN npm install
RUN npm run gulp copy

# Import image that's going to be running the app
FROM python:3

# Install uwsgi that handles communication between http server and python
RUN apt-get update && apt-get install -y build-essential python-dev sudo && pip install uwsgi flask

# Copy startup script and make it executable
WORKDIR /usr/src/app
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy compiled data from previous stage into _temp container
COPY --from=builder /usr/src/app/app/static/ /usr/src/_temp/

# Run script that:
# - Copies data from _temp folder into web root
# - Sets correct permissions on web root folder
# - Starts up uwsgi
ENTRYPOINT ["/entrypoint.sh"]