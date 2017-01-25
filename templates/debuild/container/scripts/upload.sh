#!/bin/bash
set -o xtrace

pushd build
PROJECT=xenial-mitaka dupload --to mos-linux-repo *.changes
popd

