#!/usr/bin/env bash

# more info at https://keybase.io/docs/the_app/install_linux

curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install ./keybase_amd64.deb
run_keybase
