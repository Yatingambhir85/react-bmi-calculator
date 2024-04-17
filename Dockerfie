FROM node:18

WORKDIR /app

COPY package*.json ./

EXPOSE 3000

RUN npm i

COPY . . 

CMD ["npm","start"]
