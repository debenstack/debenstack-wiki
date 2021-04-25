FROM mediawiki:1.34.2

COPY ./content/extensions /var/www/html/extensions
COPY ./content/images /var/www/html/images
COPY ./content/skins /var/www/html/skins