# PROD environment docker file

# 1st PHASE
FROM node:alpine AS builder

# Update npm
RUN npm install -g npm

# Set context dir on container
WORKDIR '/srv/http'

COPY package.json .

# Install dependencies
RUN npm install

# Copy over all source code
# Why its always two dots, not just src folder ?
COPY . .

# Result will be in folder /srv/http/build
RUN npm run build

# 2nd PHASE
FROM nginx

# Static https://hub.docker.com/_/nginx
COPY --from=builder /srv/http/build /usr/share/nginx/html

