FROM node:12-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . ./app
EXPOSE 80
ENV POT 80

CMD ["node", "server.js"]
