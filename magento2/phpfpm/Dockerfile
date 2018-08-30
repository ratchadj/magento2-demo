FROM php:7.1.21-fpm

ENV PHP_INI_DIR /usr/local/etc/php/
ENV WORKDIR /var/www/html/magento2
WORKDIR ${WORKDIR}

COPY ./customized/customized.ini $PHP_INI_DIR/conf.d/customized.ini
COPY ./customized/opcache.ini $PHP_INI_DIR/conf.d/opcache.ini

# PHP Core Extensions
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# tools
RUN apt-get install -y htop cron nano zip wget git-core gcc make

# PHP extensions for magento2
RUN apt-get install -y libicu-dev \
    libmcrypt-dev libxml2-dev libxslt-dev libzip-dev \
    && docker-php-ext-install -j$(nproc) bcmath calendar \
    exif gettext intl mcrypt mysqli pcntl pdo_mysql soap \
    sockets wddx xsl mbstring zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Download Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer