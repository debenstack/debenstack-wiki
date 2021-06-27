FROM mediawiki:1.36.0

COPY ./content/extensions /var/www/html/extensions
COPY ./content/composer.local.json /var/www/html/composer.local.json

RUN mkdir -p /var/www/html/skins/common/images && \
    chown -R www-data:www-data /var/www/html/skins/common
COPY ./content/circuit-tree160x160.png /var/www/html/skins/common/images/circuit-tree160x160.png
RUN chown www-data:www-data /var/www/html/skins/common/images/circuit-tree160x160.png

# Workdir default is /var/www/html
RUN \
    # update system
    apt-get update && \
    apt-get upgrade -y && \
    # chown our extensions
    chown -R www-data:www-data /var/www/html/extensions/mediawiki-aws-s3 &&\
    # get composer and update
    apt-get install zip unzip && \
    curl https://getcomposer.org/composer-2.phar > composer.phar && \
    php ./composer.phar update && \
    apt-get remove --purge zip unzip -y && \
    rm -f ./composer.phar

