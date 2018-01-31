FROM alpine

## alpine curl and wget aren't fully compatible, so we install them
## here. gnupg is needed for Module::Signature.
RUN apk update && apk upgrade && apk add curl tar make gcc build-base wget gnupg

RUN mkdir -p /usr/src/perl

WORKDIR /usr/src/perl

## from perl; `true make test_harness` because 3 tests fail
## some flags from http://git.alpinelinux.org/cgit/aports/tree/main/perl/APKBUILD?id=19b23f225d6e4f25330e13144c7bf6c01e624656
## from tianon/perl

RUN apk add perl
RUN curl -L https://cpanmin.us | perl - --sudo App::cpanminus

ENV PERL_CPANM_OPT --verbose --mirror https://cpan.metacpan.org --mirror-only
RUN cpanm Digest::SHA Module::Signature && rm -rf ~/.cpanm
ENV PERL_CPANM_OPT $PERL_CPANM_OPT --verify

WORKDIR /
