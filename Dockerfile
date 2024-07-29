FROM node:18-alpine
WORKDIR /app
COPY package.json src spec yarn.lock .
RUN yarn install --production
CMD ["node", "src/index.js"]
EXPOSE 80
