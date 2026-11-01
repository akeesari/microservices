FROM node:24-alpine

WORKDIR /opt/app

# Install dependencies first so this layer is cached until package files change
COPY src/package.json src/package-lock.json ./
RUN npm ci --omit=dev

COPY src/ .

ENV NODE_ENV=production
EXPOSE 3000
USER node
CMD ["npm", "start"]
