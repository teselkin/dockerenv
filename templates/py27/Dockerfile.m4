FROM ubuntu:xenial

ARG tmpdir
ARG username

RUN apt-get update && apt-get --yes upgrade

RUN apt-get install --yes \
  sudo \
  git \
  vim \
  sudo \
  python-dev \
  python3-dev \
  python-tox \
  python-setuptools \
  python-tz \
  build-essential \
  libyaml-dev

include(`setup-user')

WORKDIR /workspace
