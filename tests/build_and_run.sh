#!/bin/bash
set -e

# NOTE: Run this script at the top directory like:
# ./tests/build_and_run.sh

docker build -t testhttpclient -f tests/Dockerfile .
docker run --rm -it testhttpclient
