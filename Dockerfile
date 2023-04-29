FROM node:lts-alpine
ENV NODE_ENV=production
RUN apk update && apk add curl
WORKDIR /usr/src/app

COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install --production --silent && mv node_modules ../

COPY . .
EXPOSE 3000
RUN chown -R node /usr/src/app
USER node
CMD ["npm", "start"]

HEALTHCHECK --interval=10s --timeout=3s CMD curl -f http://localhost:3000/ || exit 1
