#!/usr/bin/env bash

docker build --file core16/Dockerfile -t cibuilds/snapcraft:core16 .
docker build --file core18/Dockerfile -t cibuilds/snapcraft:core18 .

docker tag cibuilds/snapcraft:core16 cibuilds/snapcraft:core