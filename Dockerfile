FROM node:15

WORKDIR /server

COPY package.json package-lock.json ./

RUN npm install
RUN npm install -g sequelize

COPY . .

EXPOSE 6969
