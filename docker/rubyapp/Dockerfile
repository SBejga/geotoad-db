FROM alpine:3.2
MAINTAINER Sebastian Bejga <sebastian@bejga.de>

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler

# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN mkdir /usr/rubyapp && \
	gem install mongo

ENV PATH /usr/rubyapp/:$PATH

VOLUME /usr/rubyapp
WORKDIR /usr/rubyapp

