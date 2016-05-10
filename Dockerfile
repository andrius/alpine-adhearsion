# vim:set ft=dockerfile:
FROM andrius/alpine-ruby:latest

MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>

WORKDIR /app
ADD Gemfile /app/Gemfile

RUN apk add --update --no-cache git ruby-dev build-base libxml2-dev libxslt-dev pcre-dev libffi-dev \
&&  bundle install \
&&  apk del git ruby-dev build-base libxml2-dev libxslt-dev pcre-dev libffi-dev \
&&  rm -rf /var/cache/apk/*
