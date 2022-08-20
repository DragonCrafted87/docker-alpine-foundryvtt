FROM alpine:3.16

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="DragonCrafted87 Alpine Foundry VTT Runner" \
      org.label-schema.description="Alpine Image with OpenJDK to run a minecraft server." \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/DragonCrafted87/docker-alpine-minecraft" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"


RUN apk add --no-cache --update \
        nodejs \
    && \
    rm  -rf /tmp/* /var/cache/apk/*

ARG USER=docker
ARG UID=1000
ARG GID=1000

RUN addgroup \
            --gid "$GID" \
            --system "$USER" \
      && \
      adduser \
            --disabled-password \
            --gecos "" \
            --ingroup "$USER" \
            --uid "$UID" \
            "$USER"

USER docker

WORKDIR /home/docker

RUN mkdir -p /home/docker/server \
    && mkdir -p /home/docker/data

ENTRYPOINT [ "node", "server/resources/app/main.js", "--headless", "--dataPath=/home/docker/data" ]
