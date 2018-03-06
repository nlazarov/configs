#!/usr/bin/env bash

git clone git@gitlab.com:interception/linux/tools.git
cd tools
mkdir build
cd build
cmake ..
make
sudo make install

cd ../..

git clone git@gitlab.com:interception/linux/plugins/caps2esc.git
cd caps2esc
mkdir build
cd build
cmake ..
make
sudo make install

rm -rf tools/ caps2esc/


sudo cp "$(dirname $0)/keyboard/udevmon.yaml" /etc
sudo cp "$(dirname $0)/keyboard/udevmon.service" /etc/systemd/system

sudo systemctl enable udevmon
