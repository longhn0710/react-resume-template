# Stage 1: Build stage
FROM node:18-alpine AS build
WORKDIR /app

# Copy package.json and yarn.lock
COPY package.json yarn.lock ./

# Cài đặt các dependency, bao gồm TypeScript
RUN yarn install --production --frozen-lockfile
RUN yarn add typescript --dev

# Copy các file còn lại
COPY . .

# Build ứng dụng trong chế độ production
RUN yarn build --production

# Stage 2: Production stage
FROM node:18-alpine
WORKDIR /app
COPY --from=build /app /app

# Cài đặt dependencies chỉ cho môi trường production
RUN yarn install --production

# Clean up
RUN rm -rf /app/src
