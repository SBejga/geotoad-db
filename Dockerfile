FROM alpine:3.2
MAINTAINER John Doe <john@doe.com>

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler

# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN mkdir /usr/app && \
	gem install mongo

VOLUME /usr/app
WORKDIR /usr/app

