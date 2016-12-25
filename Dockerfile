# vim:set ft=dockerfile:
FROM andrius/alpine-ruby:edge

MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>

ADD .gemrc /root/.gemrc
ADD Gemfile /tmp

WORKDIR /ahn

RUN apk add --update git ruby-dev build-base libxml2-dev libxslt-dev pcre-dev libffi-dev \
&&  cd /tmp \
&&  bundle install --system --retry 5 --jobs 4 --quiet \
&&  apk del git ruby-dev build-base libxml2-dev libxslt-dev pcre-dev libffi-dev \
&&  rm -rf /var/cache/apk/* \
&&  bundle exec ahn create /ahn \
&&  mv -f Gemfile /ahn/ \
&&  mv -f Gemfile.lock /ahn/ \
&&  mv -f .bundle /ahn/ \
&&  cd /ahn \
&&  mv config.ru RENAME-TO-config.ru-FOR-WEB-APP

# onbuild instructions - Gemfile and Gemfile.lock should present in current directory with Dockerfile
ONBUILD ADD Gemfile* /ahn/
ONBUILD RUN apk add --update git ruby-dev build-base libxml2-dev libxslt-dev pcre-dev libffi-dev \
         && bundle install --system --retry 5 --jobs 4 --quiet \
         &&  apk del git ruby-dev build-base libxml2-dev libxslt-dev pcre-dev libffi-dev \
         &&  rm -rf /var/cache/apk/*

