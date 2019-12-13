#!/bin/sh
composer install -o
chown -R www-data:www-data /var/www/html

apachectl -D FOREGROUND
