FROM php:8.1-fpm

#Verifica se o Xdebug já está instalado
RUN if ! php -m | grep -q 'xdebug'; then \
    pecl install xdebug && \
    docker-php-ext-enable xdebug \
;fi

# Instala extensões do PHP conforme necessário
# RUN docker-php-ext-install pdo pdo_sql

COPY ./config/php/conf.d/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini