#!/usr/bin/env bash

# exit immediately on error
set -e

docker build --file core18/Dockerfile -t cibuilds/snapcraft:core18 .
docker build --file core20/Dockerfile -t cibuilds/snapcraft:core20 .
