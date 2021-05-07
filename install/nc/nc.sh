#!/usr/bin/env bash

NC_DOMAIN='lazarov.cloud'
NC_DATA_ROOT=${1-/var/nextcloud}
NC_DATA="$NC_DATA_ROOT"/data
NC_ROOT=/var/www
APACHE_ROOT="$NC_ROOT"/html
NC_HOME="$NC_ROOT"/nextcloud

sudo apt full-upgrade
sudo apt install apache2

sudo a2enmod headers

sudo apt install php php-gd php-sqlite3 php-curl php-zip php-xml php-mbstring php-bz2 php-intl php-smbclient php-imap php-gmp php-bcmath php-imagick php-apcu

sudo apt install postgresql php-pgsql

sudo systemctl start postgresql.service

sudo sed -i '/^local\s\+all\s\+all\s\+peer$/s/peer/trust/g' $(pg_conftool show hba_file --short)
sudo -u postgres psql -d template1 -c "CREATE USER $USER CREATEDB; CREATE DATABASE nextcloud OWNER $USER;"

pushd "$NC_ROOT" || exit
sudo wget https://download.nextcloud.com/server/releases/latest.tar.bz2
sudo tar -xvf latest.tar.bz2

sudo mkdir -p "$NC_HOME"/data
sudo chown -R www-data:www-data "$NC_HOME"
sudo chmod 750 "$NC_HOME"/data
popd || exit

pushd "$NC_HOME" || exit
sudo -u www-data php occ maintenance:install --database=pgsql --database-name="nextcloud" --database-port='' --database-user="$USER" --database-pass='' --database-host="/var/run/postgresql" --data-dir="$NC_DATA"
popd || exit

APACHE_CONFIG_DIR=$(php -i | ag 'php.ini' | awk -F' => ' '{print $2}' | head -n 1 | sed 's/cli/apache2/')

# Configure nextcloud in apache2
sudo cp ./root_redir_htaccess $NC_ROOT/.htaccess
sudo cp ./php_apache2_conf-00-nc.ini $APACHE_CONFIG_DIR/conf.d/00-nc.ini
sudo cp ./apache2_sites_available_nextcloud.conf /etc/apache2/sites-available/nextcloud.conf
sudo a2ensite nextcloud.conf
sudo systemctl reload apache2

# Move data folder
sudo mkdir -p "$NC_DATA_ROOT"
sudo mv -v "$NC_HOME"/data "$NC_DATA_ROOT"
sudo sed -i "/datadirectory/c\\
  'datadirectory' => '$NC_DATA',\
    " "$NC_HOME"/config/config.php
sudo chown -R www-data:www-data $NC_DATA

function php_ini_update() {
  sudo sed -i "/^$1/c\\
    $1 = $2
    " $APACHE_CONFIG_DIR/php.ini
}

php_ini_update 'post_max_size' '1024M'
php_ini_update 'upload_max_filesize' '1024M'
php_ini_update 'memory_limit' '512M'

sudo systemctl reload apache2

# SSL certification
sudo apt install python3-certbot-apache
sudo certbot --apache

# exclude TLSv1 and TLSv1.1 from supported protocols by Apache
sudo sed -i '/-TLSv1/!s/^SSLProtocol.\+/\0 -TLSv1/;/-TLSv1.1/!s/^SSLProtocol.\+/\0 -TLSv1.1/;' /etc/letsencrypt/options-ssl-apache.conf

sudo systemctl reload apache2

./systemd_cron_service.sh "$NC_HOME"

# install nc apps
popd $NC_HOME || exit
$NC_APPS=(news notes carnet bookmarks)
for app in $NC_APPS
do
  sudo -u www-data php occ app:install $app
done
