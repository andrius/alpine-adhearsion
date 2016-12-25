# vim:set ft=dockerfile:
FROM ruby:alpine

MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>

ADD .gemrc /root/.gemrc
ADD Gemfile /tmp

WORKDIR /ahn

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle config git.allow_insecure true

RUN apk add --update git build-base libstdc++ pcre libffi libxml2 libxslt zlib libffi libxml2-dev libxslt-dev pcre-dev libffi-dev \
&&  cd /tmp \
&&  bundle install --system --retry 5 --jobs 4 \
&&  rm -rf /var/cache/apk/* \
&&  bundle exec ahn create /ahn \
&&  mv -f Gemfile /ahn/ \
&&  mv -f Gemfile.lock /ahn/ \
&&  cd /ahn \
&&  bundle \
&&  mv config.ru RENAME-TO-config.ru-FOR-WEB-APP

# onbuild instructions - Gemfile and Gemfile.lock should present in current directory with Dockerfile
ONBUILD ADD Gemfile* /ahn/
ONBUILD RUN bundle install --system --retry 5 --jobs 4

