#!/bin/bash

composer global require bamarni/composer-bin-plugin \
    && composer global bin churn require bmitch/churn-php \
    && composer global bin requirechecker require maglnet/composer-require-checker \
    && composer global bin rector require rector/rector
