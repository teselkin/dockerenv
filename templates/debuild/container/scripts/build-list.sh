#!/bin/bash
set -o xtrace

for name in $(cat ./build.list); do
  echo "name = '${name}'"
  if [[ ${name} =~ ^[[:blank:]]*$ ]]; then
    continue
  fi
  ./build.sh ${name}
  ./upload.sh
done

