# Import base image for build stage with Node installed
FROM node:9-alpine AS builder

# Copy build scripts and source data to be built
WORKDIR /usr/src/app/gulp
COPY ./gulp ./
COPY ./app/static-src ../app/static-src

# Install dependencies for build script and run it
RUN npm install
RUN npm run gulp copy

ENTRYPOINT ["npm", "run", "gulp"]

CMD ["watch"]

