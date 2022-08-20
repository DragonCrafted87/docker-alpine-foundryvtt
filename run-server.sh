#!/bin/bash

docker build \
        --file Dockerfile \
        --tag foundryvtt \
        .

MSYS_NO_PATHCONV=1 \
MSYS2_ARG_CONV_EXCL="*" \
    docker run -it \
        --env TZ=America/Chicago \
        --volume "$(pwd)"/mnt:/home/docker \
        --publish 30000:30000 \
        foundryvtt
