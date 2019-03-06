FROM debian:stretch
MAINTAINER Rodrigue Villetard <rodrigue@villetard.tech>

RUN apt update \
    && apt install -y curl wget apt-transport-https lsb-release ca-certificates \
    && curl  https://packages.sury.org/php/apt.gpg > /etc/apt/trusted.gpg.d/php.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt update \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  /usr/share/doc

RUN apt-get update && apt-get install -y \
    git \
    imagemagick \
    libgl1-mesa-glx \
    libsm6 \
    libxrender-dev \
    mysql-client \
    php7.3-cli \
    php7.3-imagick \
    php7.3-curl \
    php7.3-dom \
    php7.3-gd \
    php7.3-intl \
    php7.3-json \
    php7.3-mbstring \
    php7.3-mysql  \
    php7.3-pgsql  \
    php7.3-sqlite3 \
    php7.3-xsl \
    php7.3-zip \
    php7.3-gmp \
    php7.3-bcmath \
    ssmtp \
    unzip \
    vim \
    xfonts-base \
    xfonts-75dpi \
    zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc

COPY ./install-composer.sh /root/

RUN /bin/bash /root/install-composer.sh \
    && composer global require hirak/prestissimo friendsofphp/php-cs-fixer

RUN wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -q -O /opt/chrome.deb \
    && apt update && apt install -y /opt/chrome.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc

WORKDIR /app

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/.composer/vendor/bin:/app/vendor/bin

