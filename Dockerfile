FROM node:15-alpine

WORKDIR /server

COPY package.json package-lock.json ./

RUN npm install

COPY . .

EXPOSE 6969
