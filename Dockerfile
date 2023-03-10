FROM bitnami/symfony as php-fpm
WORKDIR /
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN apt update && apt install -y curl build-essential git

RUN curl -lsLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash
ENV PATH "$PATH:/root/.symfony/bin"

RUN apt install -y symfony-cli
RUN git config --global user.email "a20dariofd@iessanclemente.net"
RUN git config --global user.name "a20dariofd"
# RUN symfony server:ca:install
WORKDIR /var/www
CMD chmod -R 777 /opt/bitnami/php/var/run && cd symfony/ && chmod -R 777 . && rm -rf .git && \
    composer install && symfony serve

#FROM php:fpm AS php-container
#RUN apt-get update && apt-get install git libcurl4 libcurl3-dev libxml2-dev libzip-dev -y
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#
#RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash
#
#RUN apt update -y && apt install -y symfony-cli
#
#
#WORKDIR /var/www/symfony
#CMD symfony serve