# Stage 1: Build stage
FROM node:18-alpine AS build
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --production --frozen-lockfile
COPY . .
RUN yarn build --production

# Stage 2: Production stage
FROM node:18-alpine
WORKDIR /app
COPY --from=build /app /app
RUN yarn install --production

# Clean up
RUN rm -rf /app/src
