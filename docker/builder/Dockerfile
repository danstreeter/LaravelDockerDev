FROM php:7.2-fpm-stretch

LABEL MAINTAINER "Dan Streeter <dan@danstreeter.co.uk>"

RUN apt-get update -y && apt-get install -y \
	unzip \
	wget

WORKDIR /tmp
COPY ./docker/php/composer-install.sh /tmp/composer-install.sh
RUN chmod +x /tmp/composer-install.sh \
	&& ./composer-install.sh \
	&& chmod +x /tmp/composer.phar \
	&& mv /tmp/composer.phar /usr/local/bin/composer \
	&& rm /tmp/composer-install.sh

RUN mkdir /app
WORKDIR /app

RUN composer create-project --ignore-platform-reqs --prefer-dist laravel/laravel:~5 app

RUN tar cfvz /tmp/laravel.tar.gz ./