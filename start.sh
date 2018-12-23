#!/bin/sh

set -e

: ${ACCESS_KEY:?"ACCESS_KEY env variable is required"}
: ${SECRET_KEY:?"SECRET_KEY env variable is required"}
: ${S3_PATH:?"S3_PATH env variable is required"}
export DATA_PATH=${DATA_PATH:-/data/}

echo "access_key=$ACCESS_KEY" >> /root/.s3cfg
echo "secret_key=$SECRET_KEY" >> /root/.s3cfg

echo "Job started: $(date)"

if [[ "$1" == 'sync' ]]; then
    /usr/local/bin/s3cmd sync $PARAMS "$DATA_PATH" "$S3_PATH"
elif [[ "$1" == 'get' ]]; then
    umask 0
    /usr/local/bin/s3cmd get -r $PARAMS  "$S3_PATH" "$DATA_PATH"
elif [[ "$1" == 'del' ]]; then
    /usr/local/bin/s3cmd del -r $PARAMS "$S3_PATH"
else
    echo "Unknown command: $1"
    exit 1
fi

echo "Job finished: $(date)"
