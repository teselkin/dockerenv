# dockerenv

## Install Docker

Use the link below to find instructions on how to install docker on your
Ubuntu host:

* https://docs.docker.com/engine/installation/linux/ubuntulinux/

Do not forget to create group "docker" and add your user to that group.

## Setup dockerenv

* Clone the repository
```
git clone https://github.com/teselkin/dockerenv
```

* Make `dockerenv` available from any directory
```
alias dockerenv=$PWD/dockerenv/dockerenv
```

## Run the container

Change dir to the directory that contains files your are going to work with
(the directore that should be mounted to `/workspace` inside the container),
and enter docker env using command below:

```
dockerenv -t <template>
```

For example:

```
dockerenv -t py27
```

