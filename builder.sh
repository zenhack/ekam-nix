#!/usr/bin/env bash

set -euo pipefail

. "$stdenv/setup"

cp -r "$ekamSrc" ekam
chmod -R u+w ekam
cd ekam
mkdir -p deps
cp -r "$capnprotoSrc" deps/capnproto
chmod u+w deps/capnproto/c++/src/kj -R
sed -i 's/\/var\/tmp/\/tmp/g' deps/capnproto/c++/src/kj/filesystem-disk-test.c++
unset NIX_ENFORCE_PURITY
make
mkdir $out
cp -r bin $out
