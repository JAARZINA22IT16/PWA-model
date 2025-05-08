# Stage 1: Build the PWA
FROM node:18 AS builder

WORKDIR /app

# Copy your full app source code
COPY . .

# Install dependencies and build the app
RUN npm install
RUN npm run build

# Stage 2: Serve the built app using Apache (httpd)
FROM httpd:2.4

# Remove default Apache files
RUN rm -rf /usr/local/apache2/htdocs/*

# Copy the build output to Apache's root directory
COPY --from=builder /app/build/ /usr/local/apache2/htdocs/

EXPOSE 80

# Start Apache when the container launches
CMD ["httpd-foreground"]
