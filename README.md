hemberger/docker-backup-to-s3
=============================

[![Docker Build](https://img.shields.io/docker/automated/hemberger/docker-backup-to-s3.svg)](https://hub.docker.com/r/hemberger/docker-backup-to-s3)
[![Layers](https://images.microbadger.com/badges/image/hemberger/docker-backup-to-s3.svg)](https://microbadger.com/images/hemberger/docker-backup-to-s3)

Docker container that backs up files to Amazon S3 using [s3cmd sync](http://s3tools.org/s3cmd-sync).

### Usage

    docker run --rm [OPTIONS] hemberger/docker-backup-to-s3 [COMMAND]

### Parameters:

* `sync`, `get`, or `del`: subcommand to pass to s3cmd
* `-e ACCESS_KEY=<AWS_KEY>`: Your AWS key.
* `-e SECRET_KEY=<AWS_SECRET>`: Your AWS secret.
* `-e S3_PATH=s3://<BUCKET_NAME>/<PATH>/`: S3 Bucket name and path. Should end with trailing slash.
* `-v /path/to/backup:/data:ro`: mount target local folder to container's data folder. Content of this folder will be synced with S3 bucket.

### Optional parameters:

* `-e PARAMS="--dry-run"`: parameters to pass to the sync command ([full list here](http://s3tools.org/usage)).
* `-e DATA_PATH=/data/`: container's data folder. Default is `/data/`. Should end with trailing slash.

### Examples:

Run once to sync files in `/home/user/data` to S3:

    docker run --rm \
        -e ACCESS_KEY=myawskey \
        -e SECRET_KEY=myawssecret \
        -e S3_PATH=s3://my-bucket/backup/ \
        -v /home/user/data:/data:ro \
        hemberger/docker-backup-to-s3 sync

Run once to get file from S3:

    docker run --rm \
        -e ACCESS_KEY=myawskey \
        -e SECRET_KEY=myawssecret \
        -e S3_PATH=s3://my-bucket/backup/ \
        -v /home/user/data:/data:rw \
        hemberger/docker-backup-to-s3 get

Run once to delete files from S3:

    docker run --rm \
        -e ACCESS_KEY=myawskey \
        -e SECRET_KEY=myawssecret \
        -e S3_PATH=s3://my-bucket/backup/ \
        hemberger/docker-backup-to-s3 del

Security considerations: on restore, this opens up permissions on the restored files widely.
