FROM node:18-alpine AS build
WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Sao chép tất cả các tệp nguồn và build ứng dụng trong cùng một layer
COPY . . 
RUN yarn build

# Stage 2: Production stage
FROM node:18-alpine
WORKDIR /app

# Sao chép tất cả các tệp đã build từ stage 1 và cài đặt các dependencies chỉ cho production trong cùng một layer
COPY --from=build /app /app
RUN yarn install --production && rm -rf /app/src

