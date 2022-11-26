FROM ubuntu:22.04

ARG DEBIAN_FRONTEND="noninteractive"
ENV LANGUAGE="en_US.UTF-8" \
LANG="en_US.UTF-8" \
TERM="xterm"

WORKDIR /app
RUN apt-get update \
    && groupadd -g 1000 larawind && useradd -u 1000 -ms /bin/bash -g larawind larawind \
    && apt-get install -y gnupg software-properties-common --no-install-recommends \
    && add-apt-repository ppa:ondrej/php --yes \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
        ca-certificates \
        curl \
        unzip \
        php8.1-cli \
        php8.1-xml \
        php8.1-curl \
        php8.1-mbstring \
        php8.1-zip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get clean \
    && apt-get auto-remove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* 

COPY render /app/render
RUN chmod +x /app/render

USER larawind

ENTRYPOINT ["/app/render"]