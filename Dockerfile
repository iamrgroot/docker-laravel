ARG PHP_VERSION="7.4-fpm"

FROM php:${PHP_VERSION}

LABEL maintainer="github@rgroot.nl"

ARG NODE_VERSION=15
ARG IMAGICK=true

USER root

# Install system dependencies
RUN apt-get update > /dev/null && \
    apt-get install -y --no-install-recommends \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libmagickwand-dev \
    > /dev/null

# Install Imagick
RUN if [ "$IMAGICK" = "true" ]; then pecl install imagick > /dev/null || echo "^"; fi

# Clear cache
RUN apt-get clean > /dev/null && \
    rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    > /dev/null

# Enable Imagick
RUN if [ "$IMAGICK" = "true" ]; then docker-php-ext-enable imagick > /dev/null ; fi

# Get latest Composer
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer > /dev/null

# Install Node.js
RUN curl --silent --location https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - > /dev/null
RUN apt-get install --yes nodejs build-essential > /dev/null

# Add start script
COPY start.sh /usr/bin/start.sh

# Set working directory
WORKDIR /var/www