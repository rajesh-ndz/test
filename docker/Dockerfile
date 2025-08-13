# Stage 1: Build the NestJS app
FROM node:18-alpine AS builder

WORKDIR /app

# Copy only package files first for caching
COPY package*.json ./

# Install all dependencies including @nestjs/cli
RUN npm install

# Copy the rest of the source code
COPY . .

# Build the NestJS app (assumes main.ts and tsconfig etc. are here)
RUN npm run build

# Stage 2: Production image
FROM node:18-alpine

WORKDIR /app

# Copy package files and install production deps
COPY package*.json ./
RUN npm install --only=production

# Copy built app from builder
COPY --from=builder /app/dist ./dist

# # Add curl so HEALTHCHECK & compose checks can hit the app
# RUN apk add --no-cache curl

# # Container health (expects your app to serve /health on $PORT)
# HEALTHCHECK --interval=10s --timeout=3s --retries=12 --start-period=20s \
#     CMD curl -fsS "http://localhost:${PORT:-4000}/health" || exit 1

EXPOSE 4000
CMD ["node", "dist/main.js"]
