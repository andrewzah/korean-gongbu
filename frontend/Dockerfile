FROM node:lts-alpine as builder

WORKDIR /tmp/app

COPY package*.json ./

RUN npm install --production

COPY . .

RUN npm run build

FROM andrewzah/base-alpine:3.15

RUN apk add --no-cache caddy

COPY ./root/ /
