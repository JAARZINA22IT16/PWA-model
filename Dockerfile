# Stage 1: Build the PWA
FROM node:18 AS builder
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Stage 2: Serve using httpd
FROM httpd:2.4
COPY --from=builder /app/build/ /usr/local/apache2/htdocs/
EXPOSE 80
