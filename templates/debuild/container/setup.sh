#!/bin/bash
set -o xtrace
set -o errexit

username=$1
is_debian=false

apt-get install --yes \
  bash-completion \
  devscripts \
  dupload \
  git \
  equivs \
  vim \
  tig \
  mc \
  pbuilder \
  quilt \
  libncurses5-dev

# Fix fucking keyring in Debian
if ${is_debian} ; then
  sudo apt-get install --yes ubuntu-archive-keyring
  gpg --no-default-keyring \
    --keyring /usr/share/keyrings/debian-archive-keyring.gpg \
    --keyserver pgpkeys.mit.edu \
    --recv-key 3B4FE6ACC0B21F32
fi

cd /container
find . -name '.*' -exec cp {} /home/${username}/ \;

cp pbuilderrc /etc/

# Setup pbuilder
# ==============
echo "BUILDUSERNAME=${username}" >> /home/${username}/.pbuilderrc

# Add hook to pbuilder to enter build env if build fails
#cp C10shell /var/cache/pbuilder/hook.d/
#chmod a+x /var/cache/pbuilder/hook.d/C10shell

#cp pkg /usr/local/sbin/pkg
#chmod +x /usr/local/sbin/pkg

# Fix permissions
#chown -R ${username}:${username} /home/${username}

#pbuilder --create \
#  --distribution trusty \
#  --mirror http://mirror.yandex.ru/ubuntu
