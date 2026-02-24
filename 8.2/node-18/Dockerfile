FROM php:8.2
LABEL maintainer="CWallenberg" \
    node="18" \
    php="8.2"

WORKDIR /var/www
#COPY . /var/www

# COPY INSTALL SCRIPTS
COPY ./scripts/*.sh /var/www/
RUN chmod +x /var/www/*.sh

# Install PHP extensions and PECL modules.
RUN buildDeps=" \
        default-libmysqlclient-dev \
        libbz2-dev \
        libsasl2-dev \
    " \
    runtimeDeps=" \
        apt-utils \
        pkg-config \
        curl \
        g++ \
        gcc \
        git \
        gnupg2 \
        httpie \
        imagemagick-6-common \
        jq \
        lftp \
        libfreetype6-dev \
        libgmp-dev \
        libicu-dev \
        libjpeg-dev \
	    libjpeg62-turbo-dev \
        libldap2-dev \
        libmagickwand-6.q16-dev \
        libonig-dev \
        libpng-dev \
        libpq-dev \
        libwebp-dev \
        libxml2-dev \
        libzip-dev \
        make \
        patch \
        rsync \
        wget \
	    zip \
    " \
	&& apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y $buildDeps $runtimeDeps \
	&& bash ./nodejs-18.sh \
	&& docker-php-ext-configure zip \
    && docker-php-ext-install bcmath bz2 calendar iconv intl mbstring mysqli opcache pdo_mysql pcntl soap zip \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install gd \
	&& docker-php-ext-configure gmp \
	&& docker-php-ext-install gmp \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap \
    && docker-php-ext-install exif \
    && docker-php-ext-install opcache \
    && docker-php-ext-enable opcache \
    && apt-get purge -y --auto-remove $buildDeps \
    && sed -i 's/imagick/imagick.so/g' /usr/local/etc/php/conf.d/docker-php-ext-imagick.ini \
    #&& apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y imagemagick-6-common libmagickwand-6.q16-dev \
    && rm -r /var/lib/apt/lists/* \
    # Install Composer.
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    #&& ln -s $(composer config --global home) /root/composer \
    && rm /var/www/*.sh
ENV PATH=$PATH:/root/.composer/vendor/bin COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="/root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:$PATH"
RUN ln -s /root/.yarn/bin/yarn /usr/bin/yarn
RUN ln -s $(which php) /usr/local/bin/php8.2

# RUN php -v
