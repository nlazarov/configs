# Install and setup a nextcloud instance

This script will install a new nextcloud instance natively on  the current machine. It is intendeded to be idempotent.

## Usage

The only required parameter is the `--data-root` param. All the other params are optional:

### --data-root

The folder that would hold the nextcloud data. Inside the folder the script will create a `data/` directory, which will hold all the data.

### --domain

The domain for the nextcloud instance. It is used in settings

### --instanceid

The id of the instance. Useful when migrating an existing instance

### --passwordsalt

Useful when migrating an existing instance

### --secret

Useful when migrating an existing instance

## Some follow-up setup

### Redis
Set redis to connect through the file socket

Update the /etc/redis/redis.conf to
* set `port 0`, to disable TCP connections
* uncomment `unixsocket` and set to `/run/redis/redis-server.sock`
* uncomment `unixsocketperm` and set to `770`
