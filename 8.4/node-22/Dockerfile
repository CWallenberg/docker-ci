FROM php:8.4-cli
LABEL maintainer="CWallenberg" \
    node="22" \
    php="8.4"

WORKDIR /var/www

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
        jq \
        libfreetype6 \
        libfreetype6-dev \
        libgmp-dev \
        libicu-dev \
        libjpeg-dev \
	    libjpeg62-turbo-dev \
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
	&& docker-php-ext-configure zip \
    # Don't instal soap, mysqli
    # Skip bcmath, bz2, calendar for now
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install -j"$(nproc)" \
        intl \
        pdo_mysql \
        pcntl\
        zip \
        gd \
        gmp \
        exif \
        zip \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -r /var/lib/apt/lists/*

# Install Composer (official source)
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

# Install Node 22 from official image
COPY --from=node:22-bookworm-slim /usr/local/bin/node /usr/local/bin/node
COPY --from=node:22-bookworm-slim /usr/local/lib/node_modules /usr/local/lib/node_modules

RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx \
    && npm install --global corepack@latest \
    && ln -s $(which php) /usr/local/bin/php8.4

ENV PATH="$PATH:/root/.composer/vendor/bin" \
    COMPOSER_ALLOW_SUPERUSER=1
