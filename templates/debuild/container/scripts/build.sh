#!/bin/bash

set -o xtrace

project=$1

die() {
  echo "$@"
  exit 1
}

if [[ -z "${project}" ]]; then
  die "Please specify project name"
fi

if [[ "${project}" =~ \: ]]; then
  project_type=${project%%:*}
  project=${project##*:}
else
  project_type='openstack'
fi

rm -rf build
mkdir build
builddir=$(readlink -m build)

case ${project_type} in
  'openstack')
    pushd /workspace/openstack/${project}
    git log -1 --format='Source: [%H] %s' >> ${builddir}/changelog.txt
    popd
    cp -r /workspace/openstack/${project} ${builddir}
    rm -rf ${builddir}/${project}/debian

    pushd /workspace/openstack-build/${project}-build
    git log -1 --format='Specs: [%H] %s' >> ${builddir}/changelog.txt
    popd
    cp -r /workspace/openstack-build/${project}-build/trusty/debian ${builddir}/${project}
  ;;
  'packages')
    pushd /workspace/packages/trusty/${project}
    git log -1 --format='Source: [%H] %s' >> ${builddir}/changelog.txt
    git log -1 --format='Specs: [%H] %s' >> ${builddir}/changelog.txt
    popd

    sources=$(find /workspace/packages/trusty/${project} -mindepth 1 -maxdepth 1 -type d | grep -v -e 'debian' -e '.git' | head -1)
    cp -r ${sources} ${builddir}/${project}
    rm -rf ${builddir}/${project}/debian

    specs=$(find /workspace/packages/trusty/${project} -mindepth 1 -maxdepth 1 -type d | grep -e 'debian' | head -1)
    cp -r ${specs} ${builddir}/${project}
  ;;
  *)
    die "Project type '${project_type}' is not supported"
  ;;
esac

cd ${builddir}/${project}
name=$(dpkg-parsechangelog -S Source)
version=$(dpkg-parsechangelog -S Version)
version=${version#*:}
version=${version%%-*}

tar -czvf ../${name}_${version}.orig.tar.gz --exclude '.git' --exclude '.pc' --exclude 'debian' .

DEBFULLNAME='Dmitry Teselkin' \
  DEBEMAIL='mos-linux@mirantis.com' \
  debchange -R -D xenial "Auto rebuild for xenial-mitaka"
while read line; do
  debchange -a "${line}"
done < ${builddir}/changelog.txt

DEB_BUILD_OPTIONS=nocheck pdebuild --debbuildopts "-sa"

