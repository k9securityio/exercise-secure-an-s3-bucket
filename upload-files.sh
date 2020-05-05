#!/usr/bin/env bash
set -ex

for filenum in $(seq 1 2); do
  filename="file-${filenum}.txt"
  echo "file ${filenum}" >> "${filename}"
  for bucket in ${SENSITIVE_BUCKET} ${LOGS_BUCKET}; do
    /usr/local/bin/aws s3 cp "${filename}" "s3://${bucket}/${filename}"
  done;
done;
