#! /usr/bin/env zsh

cat << SERVICE > nextcloudcron.service
[Unit]
Description=Nextcloud cron.php job

[Service]
User=www-data
ExecStart=/usr/bin/php -f ${1-/var/www/nextcloud}/cron.php --define apc.enable_cli=1
KillMode=process
SERVICE

sudo mv nextcloudcron.service /etc/systemd/system/
sudo cp nextcloudcron.timer /etc/systemd/system/

sudo systemctl enable --now nextcloudcron.timer

