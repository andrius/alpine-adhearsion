Adhearsion on Docker
====================

The smallest Docker image with Adhearsion.

Total size of this image is only:

[![](https://images.microbadger.com/badges/image/andrius/alpine-adhearsion:3.0.0rc1-onbuild.svg)](https://microbadger.com/images/andrius/alpine-adhearsion:3.0.0rc1-onbuild "Get your own image badge on microbadger.com")

- [Github link](//github.com/andrius/alpine-adhearsion/)
- [Docker hub link](//hub.docker.com/r/andrius/alpine-adhearsion/)

This image is based on Alpine Linux image, which is only a 5MB image.

## What's included

Adhearsion 3.0.0rc1-onbuild (relese candidate) and 2.6.x-onbuild (stable)

There is project generated with `ahn create` command, and it is located in /ahn folder.
`config.ru` file renamed to remove sinatra dependency and start adhearsion (only in 3.0.0rc1).

## Usage

It can't be used separate. Easiest way to proceed is to copy content of /ahn folder from running docker container and modyfy based on your needs:

Run docker:

```
docker run -ti --rm --name ahn \
  andrius/alpine-adhearsion:3.0.0rc1-onbuild \
  sh -c "while :; do echo 'Hit CTRL+C'; sleep 3; done"
```

Copy ahn folder (do it in another terminal tab):

```
docker cp ahn:/ahn .
```

Modify Gemfile to add your gems and dependences, edit config files in ahn folder etc;

Create `.env` file within copied ahn folder, that hold credentials for Asterisk PBX or Freeswitch:

```
ASTERISK_MANAGER_USERNAME=adhearsion
ASTERISK_MANAGER_PASSWORD=somepassword
ASTERISK_PORT=5038
ASTERISK_HOST=asterisk
```

Create `Dockerfile`:

```
# vim:set ft=dockerfile:
FROM andrius/alpine-adhearsion:3.0.0rc1-onbuild

MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>

RUN apk add --update tzdata \
&&  cp -R /usr/share/zoneinfo/Europe/London /etc/localtime \
&&  echo 'Europe/London' >  /etc/timezone \
&&  apk del tzdata \
&&  rm -rf /var/cache/apk/*
```

Create `docker-compose.yml` file with following content:

```
version: '2'

services:
  ahn:
    build: .
    env_file: .env
    ports:
      - 0.0.0.0:8080:8080 # API server
    volumes:
      - "./:/ahn"
```

And start it (note, asterisk must be started before):

```
docker-compose up -d ahn
```

Now it is up and running, unless your asterisk of freeswitch credentials are wrong.

To generate new adhearsion controller, execute:

```
docker-compose run --rm ahn bundle exec ahn generate controller NAME
```
