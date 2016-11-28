FROM ubuntu:xenial
MAINTAINER MOS Linux Team <mos-linux-team@mirantis.com>
LABEL Description="Container with devscripts and configured dupload"

ENV DEBIAN_FRONTEND noninteractive

include(`setup-user-args')

RUN apt-get update \
  && apt-get upgrade --yes \
  && apt-get install --yes sudo

include(`setup-user')

RUN mkdir /container
ADD container /container
RUN chmod +x /container/*.sh
RUN /container/setup.sh ${username}

WORKDIR /workspace
