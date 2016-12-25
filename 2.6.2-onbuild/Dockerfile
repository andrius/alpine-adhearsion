# vim:set ft=dockerfile:
FROM andrius/alpine-ruby:latest

MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>

ADD .gemrc /root/.gemrc
ADD Gemfile /tmp

WORKDIR /ahn

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle config git.allow_insecure true

RUN apk add --update libstdc++ libxml2 libxslt libffi pcre zlib \
      build-base git libxml2-dev libxslt-dev libffi-dev pcre-dev ruby-dev \
&&  cd /tmp \
&&  bundle install --system --retry 5 --jobs 4 \
&&  apk del git build-base libxml2-dev libxslt-dev libffi-dev pcre-dev ruby-dev \
&&  rm -rf /var/cache/apk/* \
&&  bundle exec ahn create /ahn \
&&  mv -f Gemfile /ahn/ \
&&  mv -f Gemfile.lock /ahn/ \
&&  mv -f .vendor /ahn/ || true \
&&  cd /ahn \
&&  bundle

# onbuild instructions - Gemfile and Gemfile.lock should present in current directory with Dockerfile
ONBUILD ADD Gemfile* /ahn/
ONBUILD RUN apk add --update build-base git libxml2-dev libxslt-dev libffi-dev pcre-dev ruby-dev \
        &&  bundle install --system --retry 5 --jobs 4 \
        &&  apk del build-base git libxml2-dev libxslt-dev libffi-dev pcre-dev ruby-dev \
        &&  rm -rf /var/cache/apk/*

ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bundle", "exec", "ahn", "start", "."]

