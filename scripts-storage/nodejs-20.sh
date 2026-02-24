#!/bin/bash

set -euf -o pipefail

# NODE JS
 apt-get update \
    && echo "Package: nodejs" >> /etc/apt/preferences.d/preferences \
    && echo "Pin: origin deb.nodesource.com" >> /etc/apt/preferences.d/preferences \
    && echo "Pin-Priority: 1001" >> /etc/apt/preferences.d/preferences \
    && apt-get install -y ca-certificates curl gnupg \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /usr/share/keyrings/nodesource.gpg \
    && NODE_MAJOR=20 \
    && echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install nodejs --no-install-recommends -y \
    && npm i -g npm \
    && npm i -g gulp
    #&& curl -o- -L https://yarnpkg.com/install.sh | bash \
    #&& xargs chmod a+x $HOME/.yarn/bin/yarn
