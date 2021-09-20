#!/usr/bin/env bash

set -euo pipefail

. "$stdenv/setup"

cp -r "$ekamSrc" ekam
chmod -R u+w ekam
cd ekam
mkdir -p deps
# A single capnproto test file expects to be able to write to
# /var/tmp.  We change it to use /tmp because /var is not available
# under nix-build.
cp -r "$capnprotoSrc" deps/capnproto
chmod u+w deps/capnproto/c++/src/kj -R
sed -i 's/\/var\/tmp/\/tmp/g' deps/capnproto/c++/src/kj/filesystem-disk-test.c++
# Turn off the purity check because it doesn't fare well with ekam.
# This is also done in a handful of other expressions in nixpkgs.  See
# discussion at https://github.com/NixOS/nixpkgs/issues/13532 and at
# https://github.com/zenhack/ekam-nix/pull/4
unset NIX_ENFORCE_PURITY
make
mkdir $out
cp -r bin $out
