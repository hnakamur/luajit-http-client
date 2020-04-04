#!/bin/bash

# NOTE: Run this script at the top directory like:
# ./tests/build.sh

docker build -t httpclient -f tests/Dockerfile .
