FROM php:8.2-fpm

# composer create-project laravel/laravel . に必要
RUN apt-get update && apt-get install -y git zip unzip

# MySQLドライバ
RUN docker-php-ext-install pdo_mysql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

EXPOSE 9000
