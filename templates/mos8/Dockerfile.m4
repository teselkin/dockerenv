FROM centos:7.1.1503

include(`setup-user-args')

RUN yum install -y \
  sudo \
  vim \
  yum-utils \
  createrepo \
  tar

#RUN rm -f /etc/yum.repos.d/CentOS-Vault.repo
RUN echo 7.1.1503 > /etc/yum/vars/vaultver

#ADD CentOS-Vault.repo /etc/yum.repos.d/
#ADD mos.repo /etc/yum.repos.d/
RUN mkdir /etc/yum.conf.d
ADD yum.conf.d /etc/yum.conf.d/

#RUN yum-config-manager --disable \*
#RUN yum-config-manager --enable vault-base
#RUN yum-config-manager --enable mos-os --enable mos-updates --enable mos-proposed

#RUN yum update -y
#RUN yum -C erase fakesystemd -y

ADD mk-updates-tarball /usr/local/sbin/
RUN chmod +x /usr/local/sbin/mk-updates-tarball

include(`setup-user')

WORKDIR /workspace
