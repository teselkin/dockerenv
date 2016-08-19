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

ADD ${tmpdir}/etc/passwd /etc/
ADD ${tmpdir}/etc/group /etc/
RUN echo "${username} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${username}
RUN chmod 440 /etc/sudoers.d/${username}
RUN /sbin/mkhomedir_helper ${username}


WORKDIR /workspace
