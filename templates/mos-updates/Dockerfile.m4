FROM centos:7

include(`setup-user-args')

RUN yum install -y \
  sudo \
  vim \
  yum-utils \
  createrepo \
  tar \
  rpmdevtools

#RUN echo 7.1.1503 > /etc/yum/vars/vaultver

RUN mkdir /usr/share/mirantis
ADD mirantis /usr/share/mirantis

ADD mk-updates-tarball /usr/local/sbin/
RUN chmod +x /usr/local/sbin/mk-updates-tarball

include(`setup-user')

WORKDIR /workspace
