# docker buildx build --platform=linux/amd64 --tag danielcelliot.azurecr.io/medusajs:1.18-debian .

# Build Stage 1
FROM node:20.10.0 AS build

WORKDIR /app/medusa

COPY package*.json ./

RUN apt-get update && apt-get install -y --no-install-recommends

RUN yarn install

COPY . .

RUN yarn build


# Build Stage 2 - Production-ready image
FROM node:20.10.0-bullseye-slim

ENV NODE_ENV production

WORKDIR /app/medusa

COPY --from=build /app/medusa/dist ./
COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends

RUN yarn global add @medusajs/medusa-cli@latest
RUN yarn install --production=true

EXPOSE 9000

ENTRYPOINT ["sh", "develop.sh"]
