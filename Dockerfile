FROM mediawiki:1.36.4

COPY ./content/extensions /var/www/html/extensions
COPY ./content/composer.local.json /var/www/html/composer.local.json

RUN mkdir -p /var/www/html/skins/common/images && \
    chown -R www-data:www-data /var/www/html/skins/common
COPY ./content/circuit-tree160x160.png /var/www/html/skins/common/images/circuit-tree160x160.png
RUN chown www-data:www-data /var/www/html/skins/common/images/circuit-tree160x160.png

# Workdir default is /var/www/html
#RUN \
    # update system
RUN apt-get update
RUN apt-get upgrade -y 
    # chown our extensions
RUN chown -R www-data:www-data /var/www/html/extensions/mediawiki-aws-s3
    # get composer and update
RUN apt-get install zip unzip
RUN curl https://getcomposer.org/composer-2.phar > composer.phar
RUN php ./composer.phar config --no-plugins allow-plugins.wikimedia/composer-merge-plugin true
RUN php ./composer.phar config --no-plugins allow-plugins.composer/installers true
RUN php ./composer.phar update --prefer-stable
RUN apt-get remove --purge zip unzip -y
RUN rm -f ./composer.phar

