# vim:set ft=dockerfile:
FROM ruby:2.3.3-slim

MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>

ADD .gemrc /root/.gemrc
ADD Gemfile /tmp

WORKDIR /ahn

RUN bundle config git.allow_insecure true

RUN apt-get update \
&& apt-get -yqq --no-install-recommends --no-install-suggests install \
     git make gcc g++ ruby-dev libpcre3-dev \
&& cd /tmp \
&& bundle install --system --retry 5 --jobs 4 \
&& bundle exec ahn create /ahn \
&& mv -f Gemfile /ahn/ \
&& mv -f Gemfile.lock /ahn/ \
&& mv -f .vendor /ahn/ || true \
&& cd /ahn \
&& bundle \
&& rm -rf /usr/lib/ruby/gems/*/cache/* \
&& apt-get clean all && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man* /tmp/* /var/tmp/*

ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bundle", "exec", "ahn", "start", "."]

