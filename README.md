## Install Docker

Use the link below to find instructions on how to install docker on your Ubuntu host:

* https://docs.docker.com/engine/installation/linux/ubuntulinux/

Do not forget to create group "docker" and add your user to that group.

## Clone the repo

Clone the repository somewhere and make 'dockerenv' available via PATH variable (create a symlink or add repo to PATH).

## Run the container

CD to the directory that contains files your are going to work with (the directore that should be mounted to /workspace inside the container), and enter docker env using command below

  dockerenv -t <template>

For example:

  dockerenv -t py27

