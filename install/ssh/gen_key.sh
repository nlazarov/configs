#!/usr/bin/env bash

ssh-keygen -t ed25519 -C "${1?Provide mail, please!}"
