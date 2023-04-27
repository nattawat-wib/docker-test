FROM node:lts-alpine AS appbuild

WORKDIR /usr/src/app
COPY package.json ./
RUN yarn install
COPY . ./
RUN yarn build


FROM node:lts-alpine AS apprun
WORKDIR /usr/src/app
COPY package.json ./
RUN yarn install
COPY --from=appbuild /usr/src/app/dist ./dist
EXPOSE 8080
CMD ["node", "dist/app.js"]