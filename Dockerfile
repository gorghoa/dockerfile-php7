FROM debian:buster
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
    php7.1-cli \
    php7.1-imagick \
    php7.1-curl \
    php7.1-dom \
    php7.1-gd \
    php7.1-intl \
    php7.1-json \
    php7.1-mbstring \
    php7.1-mysql  \
    php7.1-pgsql  \
    php7.1-sqlite3 \
    php7.1-xsl \
    php7.1-zip \
    php7.1-gmp \
    php7.1-bcmath \
    msmtp \
    unzip \
    vim \
    xfonts-base \
    xfonts-75dpi \
    zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc

COPY ./install-composer.sh /root/

RUN /bin/bash /root/install-composer.sh \
    && composer global require hirak/prestissimo friendsofphp/php-cs-fixer phpstan/phpstan


RUN wget -q -O ~/FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64" \
    && tar xjf ~/FirefoxSetup.tar.bz2 -C /opt/ \
    && ln -s /opt/firefox/firefox /usr/local/bin/firefox \
    && rm ~/FirefoxSetup.tar.bz2

WORKDIR /app

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/.composer/vendor/bin:/app/vendor/bin
