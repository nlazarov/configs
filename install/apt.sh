#!/usr/bin/env bash

cat "$(dirname $0)/apt.packages" | xargs sudo apt install --yes
