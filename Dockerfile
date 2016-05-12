# vim:set ft=dockerfile:
FROM andrius/alpine-ruby:latest

MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>

WORKDIR /app

ADD Gemfile /tmp/Gemfile

RUN apk add --update --no-cache git ruby-dev build-base libxml2-dev libxslt-dev pcre-dev libffi-dev \
&&  cd /tmp \
&&  bundle install --system \
&&  apk del git ruby-dev build-base libxml2-dev libxslt-dev pcre-dev libffi-dev \
&&  rm -rf /var/cache/apk/* \
&&  bundle exec ahn create /app \
&&  cp -R Gemfile /app/ \
&&  cp -R Gemfile.lock /app/ \
&&  rm -f Gemfile Gemfile.lock \
&&  cd /app \
&&  bundle --local

