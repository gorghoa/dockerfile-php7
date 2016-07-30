FROM debian:jessie

RUN apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  /usr/share/doc

RUN echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list

RUN curl https://www.dotdeb.org/dotdeb.gpg > dotdeb.gpg \
    && apt-key add dotdeb.gpg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  /usr/share/doc

# not found php7.0-mcrypt vim php7.0-xdebug php7.0-xsl php7.0-imagick
RUN apt-get update && apt-get install -y \
    entr \
    git \
    imagemagick \
    libgl1-mesa-glx \
    libsm6 \
    libxrender-dev \
    mysql-client \
    php7.0-mysql  \
    php7.0-pgsql  \
    php7.0-sqlite3 \
    php7.0-json \
    php7.0-curl \
    php7.0-gd \
    php7.0-cli \
    php7.0-intl \
    ssmtp \
    vim \
    xfonts-base \
    xfonts-75dpi \
    zip \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  /usr/share/doc

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"  \
    && php composer-setup.php --install-dir=/usr/local/bin --filename composer \
    && php -r "unlink('composer-setup.php');"

RUN composer global require hirak/prestissimo friendsofphp/php-cs-fixer

WORKDIR /app

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/.composer/vendor/bin:/app/vendor/bin

