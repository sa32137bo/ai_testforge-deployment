# Stage 1 — Build React app
FROM node:20-alpine AS builder
WORKDIR /app

# Copy and install dependencies
COPY package*.json ./
RUN npm install

# Copy source files
COPY . .

# Fix permission issues for binaries like react-scripts
RUN chmod +x node_modules/.bin/*

# Build the app
RUN npm run build

# Stage 2 — Serve with Nginx
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
