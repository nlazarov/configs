#!/usr/bin/env bash

sudo apt full-upgrade
sudo apt install apache2

sudo apt install php7.3 php7.3-gd php7.3-sqlite3 php7.3-curl php7.3-zip php7.3-xml php7.3-mbstring php7.3-bz2 php7.3-intl php7.3-smbclient php7.3-imap php7.3-gmp

sudo apt install postgresql php-pgsql

sudo sed -i '/^local\s\+all\s\+all\s\+peer$/s/peer/trust/g' /etc/postgresql/11/main/pg_hba.conf
sudo -u postgres psql -d template1 -c 'CREATE USER pi CREATEDB;CREATE DATABASE nextcloud OWNER pi;'

NC_DOMAIN='lazarov.cloud'
NC_DATA_ROOT=/var/nextcloud
NC_DATA="$NC_DATA_ROOT"/data
NC_ROOT=/var/www
NC_HOME="$NC_ROOT"/nextcloud

pushd "$NC_ROOT" || exit
sudo wget https://download.nextcloud.com/server/releases/latest.tar.bz2
sudo tar -xvf latest.tar.bz2

sudo mkdir -p "$NC_HOME"/data
sudo chown -R www-data:www-data "$NC_HOME"
sudo chmod 750 "$NC_HOME"/data
popd || exit

# Configure nextcloud in apache2
sudo cp ./apache2_sites_available_nextcloud.conf /etc/apache2/sites-available/nextcloud.conf
sudo a2ensite nextcloud.conf
sudo systemctl reload apache2

# Move data folder
sudo mkdir -p "$NC_DATA_ROOT"
sudo mv -v "$NC_HOME"/data "$NC_DATA"
sudo sed -i "/datadirectory/c\\
  'datadirectory' => '$NC_DATA',\
    " "$NC_HOME"/config/config.php
sudo chown -R www-data:www-data $NC_DATA

# update upload max size
sudo sed -i "/^post_max_size/c\\
  post_max_size = 1024M
  " /etc/php/7.3/apache2/php.ini

sudo sed -i "/^upload_max_filesize/c\\
  upload_max_filesize = 1024M
  " /etc/php/7.3/apache2/php.ini

sudo systemctl reload apache2

# SSL certification
sudo apt install python-certbot-apache
sudo certbot --apache

# exclude TLSv1 and TLSv1.1 from supported protocols by Apache
sed -i '/-TLSv1/!s/^SSLProtocol.\+/\0 -TLSv1/;/-TLSv1.1/!s/^SSLProtocol.\+/\0 -TLSv1.1/;' /etc/letsencrypt/options-ssl-apache.conf

sudo systemctl reload apache2

./systemd_cron_service.sh "$NC_HOME"

