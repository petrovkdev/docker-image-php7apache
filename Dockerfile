# Для начала указываем исходный образ, он будет использован как основа
FROM php:7.3-apache

# RUN выполняет идущую за ней команду в контексте нашего образа.
# В данном случае мы установим некоторые зависимости и модули PHP.
# Для установки модулей используем команду docker-php-ext-install.
# На каждый RUN создается новый слой в образе, поэтому рекомендуется объединять команды.
RUN apt-get update && apt-get install -y \
        && apt-get install -y libzip-dev \
        && apt-get install -y zlib1g-dev \
        && apt-get install -y libgd-dev \
        && apt-get install -y libjpeg62-turbo-dev \
        && apt-get install -y libpng-dev \
        && apt-get install -y libmcrypt-dev \
        && apt-get install -y g++ \
        && rm -rf /var/lib/apt/lists/* \
        && docker-php-ext-install -j$(nproc) iconv mbstring mysqli pdo_mysql zip \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd \
