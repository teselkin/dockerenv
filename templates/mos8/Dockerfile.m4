FROM centos:7.1.1503

include(`setup-user-args')

RUN yum install -y \
  sudo \
  vim \
  yum-utils \
  createrepo

RUN rm -f /etc/yum.repos.d/CentOS-Vault.repo
RUN echo 7.1.1503 > /etc/yum/vars/releasever

ADD CentOS-Vault.repo /etc/yum.repos.d/
ADD mos.repo /etc/yum.repos.d/

RUN yum-config-manager --disable \*
RUN yum-config-manager --enable vault-base --enable vault-updates

#RUN yum-config-manager --enable mos-base --enable mos-centos --enable mos-os --enable mos-updates --enable mos-proposed

RUN yum update -y
#RUN yum -C erase fakesystemd -y

include(`setup-user')

WORKDIR /workspace
