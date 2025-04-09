#!/bin/sh -e
bundle exec ridgepole -c config/database.yml -a > /dev/null 2>&1
exec "$@"
