FROM php:7.2-fpm-stretch

LABEL MAINTAINER "Dan Streeter <dan@danstreeter.co.uk>"

RUN apt-get update -y && apt-get install -y \
	libjpeg62-turbo-dev \
	libpng-dev \
	libfreetype6-dev \
	openssl \
	unzip \
	wget \
	zip

RUN docker-php-ext-install exif mbstring pdo pdo_mysql mysqli
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

WORKDIR /tmp
COPY ./docker/php/composer-install.sh /tmp/composer-install.sh
RUN chmod +x /tmp/composer-install.sh \
	&& ./composer-install.sh \
	&& chmod +x /tmp/composer.phar \
	&& mv /tmp/composer.phar /usr/local/bin/composer \
	&& rm /tmp/composer-install.sh


RUN mkdir /app
WORKDIR /app


# DEBUG STUFF
# RUN pecl install xdebug-2.7.2 \
#     && docker-php-ext-enable xdebug
# RUN mkdir /tmp/xdebug-profile-output && chmod 777 /tmp/xdebug-profile-output

# SSMPT Redirct outbound mail to mailhog
# RUN apt-get install -y ssmtp \
# 	&& sed -i "/^mailhub=/s/=.*/=mailhog:1025/" /etc/ssmtp/ssmtp.conf

### NO INSTALLS BELOW THIS POINT - ONLY CONFIG COPY INS ####

COPY ./docker/php/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY ./docker/php/sendmail.ini /usr/local/etc/php/conf.d/sendmail.ini

