FROM node:9-alpine

WORKDIR /usr/src/app/gulp

COPY package.json /package.json

RUN npm install

USER 33

ENTRYPOINT ["npm", "run", "gulp"]

CMD ["watch"]

