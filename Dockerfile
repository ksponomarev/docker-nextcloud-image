FROM nextcloud:fpm

RUN set -x \
    && apt update -qq\
    && apt install -y nginx sudo

COPY data/nginx/sites-available/default /etc/nginx/sites-enabled/default
COPY data/nginx/nginx.conf /etc/nginx/nginx.conf
COPY data/*.sh /

RUN set -x && apt install -y supervisor \
    && chmod 755 /start.sh \
    && chmod 755 /entrypoint.sh \
    && mkdir /run/php && chown -R 33:33 /run/php\
    && apt-get autoremove -y\
    && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*

COPY data/supervisord/supervisord.conf /etc/supervisor/supervisord.conf
COPY data/supervisord/conf.d/ /etc/supervisor/conf.d/
#COPY data/php/fpm/www.conf /usr/local/etc/php-fpm.d/www.conf.default

CMD ["/bin/sh", "/start.sh"]
