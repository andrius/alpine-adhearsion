# vim:set ft=dockerfile:
FROM andrius/alpine-ruby:latest

MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>

ADD .gemrc /root/.gemrc
ADD Gemfile /ahn-temp/Gemfile

WORKDIR /ahn

RUN apk add --update libstdc++ libxml2 libxslt libffi pcre zlib \
      build-base git libxml2-dev libxslt-dev libffi-dev pcre-dev ruby-dev \
&&  cd /ahn-temp/ \
&&  bundle install --system --retry 5 --jobs 4 \
&&  bundle exec ahn create /ahn \
&&  mv -f Gemfile /ahn/ \
&&  mv -f Gemfile.lock /ahn/ \
&&  mv -f .vendor /ahn/ || true \
&&  cd /ahn \
&&  bundle \
&&  rm -rf /usr/lib/ruby/gems/*/cache/* \
&&  apk del git build-base libxml2-dev libxslt-dev libffi-dev pcre-dev ruby-dev \
&&  rm -rf /var/cache/apk/* /tmp /ahn-temp \

# onbuild instructions - Gemfile and Gemfile.lock should present in current directory with Dockerfile
ONBUILD ADD Gemfile* /ahn/
ONBUILD RUN apk add --update build-base git libxml2-dev libxslt-dev libffi-dev pcre-dev ruby-dev \
        &&  cd /ahn \
        &&  bundle install --system --retry 5 --jobs 4 \
        &&  rm -rf /usr/lib/ruby/gems/*/cache/* \
        &&  apk del build-base git libxml2-dev libxslt-dev libffi-dev pcre-dev ruby-dev \
        &&  rm -rf /var/cache/apk/* /tmp

ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bundle", "exec", "ahn", "start", "."]

