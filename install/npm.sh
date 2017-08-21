#!/usr/bin/env bash

cat "$(dirname $0)/npm.packages" | xargs npm install -g
