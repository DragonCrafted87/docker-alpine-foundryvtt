# syntax=docker/dockerfile:1
FROM dragoncrafted87/alpine:3.19

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="DragonCrafted87 Alpine Foundry VTT Runner" \
    org.label-schema.description="Alpine Image with Node to run a Foundry VTT server." \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/DragonCrafted87/docker-alpine-foundryvtt" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"

RUN ash <<eot
    apk add --no-cache --update \
        nodejs \

    rm -rf /tmp/*
    rm -rf /var/cache/apk/*
    chmod +x -R /scripts/*
eot

ARG USER=docker
ARG UID=1000
ARG GID=1000

RUN ash <<eot
    addgroup \
        --gid "$GID" \
        --system "$USER"

    adduser \
        --disabled-password \
        --gecos "" \
        --ingroup "$USER" \
        --uid "$UID" \
        "$USER"
eot

USER docker

WORKDIR /home/docker

ENTRYPOINT [ "node", "server/resources/app/main.js", "--headless", "--dataPath=/home/docker/data" ]
