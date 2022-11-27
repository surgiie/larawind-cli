FROM ubuntu:22.04

ARG DEBIAN_FRONTEND="noninteractive"
ENV LANGUAGE="en_US.UTF-8" \
LANG="en_US.UTF-8" \
TERM="xterm"

WORKDIR /var/www/html
RUN apt-get update \
    && groupadd -g {{ $dockerUserUid }} {{ $dockerUsername }} && useradd -u {{ $dockerUserUid }} -ms /bin/bash -g {{ $dockerUsername }} {{ $dockerUsername }} \
    && apt-get install -y gnupg software-properties-common --no-install-recommends \
    && add-apt-repository ppa:ondrej/php --yes \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
        ca-certificates \
        curl \
        unzip \
        php8.1-cli \
        php8.1-fpm \
        php8.1-common \
        php8.1-curl \
        php8.1-gd \
        php8.1-mbstring \
        php8.1-mysql \
        php8.1-redis \
        php8.1-xml \
        php8.1-zip \
        mysql-client \
    && curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get -y --no-install-recommends install nodejs \
    && apt-get clean \
    && apt-get auto-remove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && chmod 777 /var/www/html \
    &&  chown -R {{ $dockerUsername }}:{{ $dockerUsername }} /var/run/ \
    &&  chown -R {{ $dockerUsername }}:{{ $dockerUsername }} /run/

USER {{ $dockerUsername }}

CMD ["/usr/sbin/php-fpm8.1", "--nodaemonize"]
