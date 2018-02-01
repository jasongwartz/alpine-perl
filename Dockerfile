FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add \
        curl tar make gcc build-base wget gnupg \
        perl perl-dev

RUN curl -L https://cpanmin.us | perl - App::cpanminus &&\
    mkdir -p /usr/src/perl

WORKDIR /usr/src/perl
