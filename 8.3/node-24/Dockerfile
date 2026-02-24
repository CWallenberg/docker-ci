FROM php:8.3
LABEL maintainer="CWallenberg" \
    node="24" \
    php="8.3"

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
        libfreetype6 \
        libfreetype6-dev \
        libgmp-dev \
        libicu-dev \
        libjpeg-dev \
	    libjpeg62-turbo-dev \
        libldap2-dev \
        libmagickwand-7.q16-dev \
        libonig-dev \
        libpng-dev \
        libpq-dev \
        libproc2-0 \
        libwebp-dev \
        libxml2-dev \
        libzip-dev \
        make \
        patch \
        procps \
        psmisc \
        rsync \
        wget \
	    zip \
    " \
	&& apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y $buildDeps $runtimeDeps \
	&& bash ./nodejs-24.sh \
	&& docker-php-ext-configure zip \
    # Don't instal soap, mysqli
    && docker-php-ext-install bcmath bz2 calendar iconv intl mbstring opcache pdo_mysql pcntl zip \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install gd \
	&& docker-php-ext-configure gmp \
	&& docker-php-ext-install gmp \
    && docker-php-ext-install exif \
    && docker-php-ext-install opcache \
    && docker-php-ext-enable opcache \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -r /var/lib/apt/lists/* \
    # Install Composer.
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    #&& ln -s $(composer config --global home) /root/composer \
    && rm /var/www/*.sh
ENV PATH=$PATH:/root/.composer/vendor/bin COMPOSER_ALLOW_SUPERUSER=1
#ENV PATH="/root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:$PATH"
RUN npm install --global corepack@latest
#RUN ln -s /root/.yarn/bin/yarn /usr/bin/yarn
#RUN wget -qO- https://get.pnpm.io/install.sh | ENV="$HOME/.shrc" SHELL="$(which sh)" sh -
#ENV PATH="/root/.local/share/pnpm:$PATH"
#RUN ln -s /root/.local/share/pnpm/pnpm /usr/bin/pnpm
RUN ln -s $(which php) /usr/local/bin/php8.3

# RUN php -v
