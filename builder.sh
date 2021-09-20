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
sed -i 's|/var/tmp|/tmp|g' deps/capnproto/c++/src/kj/filesystem-disk-test.c++

# NIX_ENFORCE_PURITY prevents ld from linking against anything outside of the
# nix store -- but ekam builds capnp locally and links against it, so that causes
# the build to fail. So, we turn this off.
#
# See: https://nixos.wiki/wiki/Development_environment_with_nix-shell#Troubleshooting
unset NIX_ENFORCE_PURITY

make
mkdir $out
cp -r bin $out
