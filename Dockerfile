ARG PHP_VERSION="7.4-fpm"

FROM php:${PHP_VERSION}

ARG NODE_VERSION=14
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

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u 1234 -d /home/laravel laravel
RUN mkdir -p /home/laravel/.composer

# Start script
COPY start.sh /home/laravel/start

# Permission
RUN chown -R laravel:laravel /home/laravel
RUN chmod +x /home/laravel/start

# Set working directory
WORKDIR /var/www

USER laravel

CMD ["/home/laravel/start"]