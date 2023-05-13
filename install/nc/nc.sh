#!/usr/bin/env bash

NC_DOMAIN='lazarov.cloud'
NC_ROOT=/var/www
APACHE_ROOT="$NC_ROOT"/html
NC_HOME="$NC_ROOT"/nextcloud

while [ $# -gt 0 ]; do
  case $1 in

    --data-root)
      NC_DATA_ROOT=$2
      NC_DATA="$NC_DATA_ROOT"/data
      shift 2
      ;;

    --domain)
      NC_DOMAIN=${2-lazarov.cloud}
      shift 2
      ;;

    --instanceid)
      NC_INSTANCEID=$2
      shift 2
      ;;

    --passwordsalt)
      NC_PASSWORDSALT=$2
      shift 2
      ;;

    --secret)
      NC_SECRET=$2
      shift 2
      ;;

    *)
      echo 'Initializing nextcloud instance'
  esac
done

[[ -z "$NC_DATA_ROOT" ]] && echo 'Define --data-root param' && exit 1

sudo apt full-upgrade
sudo apt install apache2

sudo a2enmod headers

sudo apt install ffmpeg php php-gd php-sqlite3 php-curl php-zip php-xml php-mbstring php-bz2 php-intl php-smbclient php-imap php-gmp php-bcmath php-imagick php-apcu libmagickcore-6.q16-6-extra

sudo apt install postgresql php-pgsql

sudo systemctl start postgresql.service

sudo sed -i '/^local\s\+all\s\+all\s\+peer$/s/peer/trust/g' "$(pg_conftool show hba_file --short)"
sudo -u postgres psql -d template1 -c "CREATE USER $USER CREATEDB; CREATE DATABASE nextcloud OWNER $USER;"
createdb nextcloud

pushd "$NC_ROOT" || exit
sudo wget https://download.nextcloud.com/server/releases/latest.tar.bz2
sudo tar -xvf latest.tar.bz2
popd || exit

sudo chown -R www-data:www-data "$NC_HOME"
# sudo chmod 750 "$NC_HOME"/data

sudo -u www-data mkdir -p "$NC_DATA"

pushd "$NC_HOME" || exit
sudo -u www-data php occ maintenance:install --database=pgsql --database-name="nextcloud" --database-port='' --database-user="$USER" --database-pass='' --database-host="/var/run/postgresql" --data-dir="$NC_DATA"

function nc_conf() {
  sudo -u www-data php occ config:system:set --value="$2" "$1" $3
}

[[ -n $NC_INSTANCEID ]]  && nc_conf 'instanceid' "$NC_INSTANCEID"
[[ -n $NC_PASSWORDSALT ]]  && nc_conf 'passwordsalt' "$NC_PASSWORDSALT"
[[ -n $NC_SECRET ]]  && nc_conf 'secret' "$NC_SECRET"

nc_conf 'trusted_domains' 'localhost' 0
nc_conf 'trusted_domains' "$(hostname -I | cut -d' ' -f1)" 1
nc_conf 'trusted_domains' "$(hostname)" 2
nc_conf 'trusted_domains' "$NC_DOMAIN" 3

nc_conf 'overwrite.cli.url' "https://$NC_DOMAIN/nextcloud"

nc_conf 'memcache.local' '\OC\Memcache\APCu'
nc_conf 'enable_previews' 'true'

nc_conf 'enabledPreviewProviders' 'OC\Preview\TXT' 0
nc_conf 'enabledPreviewProviders' 'OC\Preview\MarkDown' 1
nc_conf 'enabledPreviewProviders' 'OC\Preview\Image' 2
nc_conf 'enabledPreviewProviders' 'OC\Preview\TIFF' 3
nc_conf 'enabledPreviewProviders' 'OC\Preview\SVG' 4
nc_conf 'enabledPreviewProviders' 'OC\Preview\Font' 5
nc_conf 'enabledPreviewProviders' 'OC\Preview\MP3' 6
nc_conf 'enabledPreviewProviders' 'OC\Preview\Movie' 7
nc_conf 'enabledPreviewProviders' 'OC\Preview\MKV' 8
nc_conf 'enabledPreviewProviders' 'OC\Preview\MP4' 9
nc_conf 'enabledPreviewProviders' 'OC\Preview\AVI' 10

popd || exit

APACHE_CONFIG_DIR=$(php -i | ag 'php.ini' | awk -F' => ' '{print $2}' | head -n 1 | sed 's/cli/apache2/')

# Configure nextcloud in apache2
sudo cp ./root_redir_htaccess $APACHE_ROOT/.htaccess
sudo cp ./php_apache2_conf-00-nc.ini "$APACHE_CONFIG_DIR/conf.d/00-nc.ini"
sudo cp ./apache2_sites_available_nextcloud.conf /etc/apache2/sites-available/nextcloud.conf
sudo a2ensite nextcloud.conf
sudo systemctl reload apache2

function php_ini_update() {
  sudo sed -i "/^;\?$1/c\\
    $1 = $2
    " "$APACHE_CONFIG_DIR/php.ini"
}

php_ini_update 'post_max_size' '1024M'
php_ini_update 'upload_max_filesize' '1024M'
php_ini_update 'memory_limit' '3072M'
php_ini_update 'opcache.enable' '1'
php_ini_update 'opcache.memory_consumption' '128'
php_ini_update 'opcache.interned_strings_buffer' '32'

sudo systemctl reload apache2

# SSL certification
sudo apt install python3-certbot-apache
if [[ $(sudo certbot certificates | grep "$NC_DOMAIN") == '' ]]; then
  sudo certbot --apache
fi

if [[ $(grep 'Directory /var/www/html' /etc/apache2/sites-available/000-default-le-ssl.conf) == '' ]]; then
cat <<REDIR | sudo tee -a /etc/apache2/sites-available/000-default-le-ssl.conf
<Directory /var/www/html>
  AllowOverride All
</Directory>
REDIR
fi

# exclude TLSv1 and TLSv1.1 from supported protocols by Apache
sudo sed -i '/-TLSv1/!s/^SSLProtocol.\+/\0 -TLSv1/;/-TLSv1.1/!s/^SSLProtocol.\+/\0 -TLSv1.1/;' /etc/letsencrypt/options-ssl-apache.conf

sudo systemctl reload apache2

./systemd_cron_service.sh "$NC_HOME"

# install nc apps
pushd "$NC_HOME" || exit
NC_APPS=(bookmarks calendar contacts cookbook deck gpoddersync maps news notes previewgenerator recognize richdocuments richdocuments_arm64 tasks)
for app in $NC_APPS
do
  sudo -u www-data php occ app:install $app
done
popd || exit
