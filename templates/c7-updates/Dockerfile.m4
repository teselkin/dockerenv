FROM centos:7

include(`setup-user-args')

RUN yum update -y
RUN yum install sudo vim -y
RUN yum install yum-utils createrepo -y

include(`setup-user')

WORKDIR /workspace
