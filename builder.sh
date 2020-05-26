#!/usr/bin/env bash

set -euo pipefail

. "$stdenv/setup"

cp -r "$ekamSrc" ekam
chmod -R u+w ekam
cd ekam
mkdir -p deps
ln -s "$capnprotoSrc" deps/capnproto

# Work around https://github.com/capnproto/ekam/issues/29
make 2>&1 | cat
