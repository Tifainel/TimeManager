FROM node:10.22.1-alpine3.11

WORKDIR /src
COPY ./ /src
 
RUN npm install
RUN npm run build

CMD ["npm", "run", "serve"]