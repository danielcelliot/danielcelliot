# docker build -t danielcelliot.azurecr.io/medusajs:latest .

# Set the base image to Node 18
FROM node:18-alpine

WORKDIR /app/medusa

COPY package.json .
COPY develop.sh .
COPY yarn.* .

# update package information
RUN apk update

# Install dependencies
RUN yarn

# Install the medusa-cli
RUN yarn global add @medusajs/medusa-cli@latest

COPY . .

# Set the default command to run when the container starts
ENTRYPOINT ["sh", "develop.sh"]
