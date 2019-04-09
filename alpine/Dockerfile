FROM nextcloud:fpm-alpine

RUN set -x \
    && apk update\
    && apk add --no-cache nginx sudo

COPY data/nginx/sites-available/default /etc/nginx/sites-enabled/default
COPY data/nginx/nginx.conf /etc/nginx/nginx.conf
COPY data/*.sh /

RUN set -x && apk add --no-cache supervisor \
    && chmod 755 /start.sh \
    && chmod 755 /entrypoint.sh \
    && mkdir /run/php && chown -R 33:33 /run/php
    #&& rm /usr/local/etc/php-fpm.d/www.conf.default

COPY data/supervisord/supervisord.conf /etc/supervisor/supervisord.conf
COPY data/supervisord/conf.d/ /etc/supervisor/conf.d/
#COPY data/php/fpm/www.conf /usr/local/etc/php-fpm.d/www.conf.default

CMD ["/bin/sh", "/start.sh"]
