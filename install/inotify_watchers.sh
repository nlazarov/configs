#!/usr/bin/env bash

echo "fs.inotify.max_user_watches=524280" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
