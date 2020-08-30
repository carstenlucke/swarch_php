FROM php:7-fpm

RUN apt-get update && apt-get install -y git vim zip --no-install-recommends

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '572cb359b56ad9ae52f9c23d29d4b19a040af10d6635642e646a7caa7b96de717ce683bd797a92ce99e5929cc51e7d5f') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --filename=composer --install-dir=/usr/local/bin \
    && php -r "unlink('composer-setup.php');"


# Install needed php extensions: ldap, pdo_mysql
RUN \
    apt-get update && \
    apt-get install libldap2-dev -y && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap && \
    docker-php-ext-install pdo_mysql

# install xdebug zend-extension
RUN pecl install xdebug-2.9.6 && docker-php-ext-enable xdebug
RUN echo 'zend_extension="/usr/local/lib/php/extensions/no-debug-non-zts-20180731/xdebug.so"' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.idekey=IDEA' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.default_enable=1' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_enable=1' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_autostart=1' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_host=host.docker.internal' >> /usr/local/etc/php/php.ini
RUN echo 'xdebug.remote_port=10000' >> /usr/local/etc/php/php.ini
