#!/bin/sh

set -e

mkdir -p ~/.aws
touch ~/.aws/credentials
touch ~/.aws/config

echo "[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}" > ~/.aws/credentials

echo "[default]
retry_mode = standard
max_attempts = 3" > ~/.aws/config

aws s3 cp ${FILE} s3://${AWS_S3_BUCKET}${AWS_S3_PATH} \
            --region ${AWS_REGION} $*

status=$?

rm -rf ~/.aws

exit $status
