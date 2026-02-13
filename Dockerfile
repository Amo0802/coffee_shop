# ---- build stage ----
FROM ghcr.io/cirruslabs/flutter:3.29.0 AS build

WORKDIR /app

# Install deps first (better caching)
COPY pubspec.* ./
RUN flutter pub get

# Copy rest and build
COPY . .
RUN flutter build web --release

# ---- runtime stage ----
FROM nginx:alpine

# Nginx config for SPA routing + caching
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Static files
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
