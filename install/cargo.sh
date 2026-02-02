#!/usr/bin/env bash

cat "$(dirname $0)/cargo.packages" | xargs cargo install --locked
