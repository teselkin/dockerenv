FROM centos:7

include(`setup-user-args')

RUN yum update -y
RUN yum install sudo vim -y
RUN yum install yum-utils createrepo -y

ADD mk-updates-tarball /usr/local/sbin/
RUN chmod +x /usr/local/sbin/mk-updates-tarball

include(`setup-user')

WORKDIR /workspace
