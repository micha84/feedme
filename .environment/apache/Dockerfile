ARG PHP_VERSION
FROM php:${PHP_VERSION}-apache
MAINTAINER Michael Arndt <michael.arndt@exconcept.com>

RUN a2enmod rewrite

# install system dependencies
RUN apt-get update \
    && apt-get install -y apt-utils

RUN apt-get install -y \
        gnupg \
        vim \
        git \
        curl \
        wget \
        unzip \
        sudo \
        libpq-dev \
        zlib1g-dev \
        libzip-dev \
        libicu-dev \
        g++ \
        libgmp-dev libmcrypt-dev libbz2-dev libpng-dev libjpeg62-turbo-dev \
        libfreetype6-dev libfontconfig \
        librabbitmq-dev \
        libssl-dev \
        gcc \
        make \
        autoconf \
        libc-dev \
        pkg-config \
        # CAUTION: PHP 7.3 Ships with debian buster and uses mariadb-client instead of mysql-client:
        # See here: https://stackoverflow.com/questions/57048428/e-package-mysql-client-has-no-installation-candidate-in-php-fpm-image-build-u
#        mysql-client
        mariadb-client

# install required php extensions
RUN docker-php-ext-install -j$(nproc) iconv pdo pgsql pdo_pgsql mysqli pdo_mysql intl bcmath gmp bz2 zip \
 && apt-get clean

# configure php extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install -j$(nproc) gd

RUN pecl install -o -f redis \
 && pecl install -o -f xdebug \
 && docker-php-ext-enable redis \
 && docker-php-ext-enable xdebug \
 && echo "" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.default_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.profiler_enable=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.remote_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.inactive

RUN echo "memory_limit = 2048M" >> /usr/local/etc/php/conf.d/docker-exconcept-ext.ini

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/local/bin/composer \
 && chmod +x /usr/local/bin/composer

RUN mkdir -p /home/www && \
    chown www-data:www-data /home/www && \
    usermod -s /bin/bash www-data -d /home/www

USER www-data
RUN composer global require hirak/prestissimo
WORKDIR /var/www/html

USER root
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
#RUN chmod +x /tmp/scripts/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
