#!/usr/bin/env bash

set -euo pipefail

. "$stdenv/setup"

cp -r "$ekamSrc" ekam
chmod -R u+w ekam
cd ekam
mkdir -p deps
ln -s "$capnprotoSrc" deps/capnproto
make
