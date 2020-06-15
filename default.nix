{ pkgs ? import <nixpkgs> {} }:
let
  ekamSrc = pkgs.fetchFromGitHub {
    owner = "capnproto";
    repo = "ekam";
    # Master as of 2020-06-15
    rev = "996b62fb24d9cb18fc7d6c0facaccf8f7d057a68";
    sha256 = "07c5044dscp3aqf5r46k5ph9sjfw5m7skgj0kzb07rf05g994xdf";
  };
  capnprotoSrc = pkgs.fetchFromGitHub {
    owner = "capnproto";
    repo = "capnproto";
    rev = "v0.8.0";
    sha256 = "0z7p9687bdvhddgyb6b3j0c3bngynnyvc8z6yp4hhynvrlvsmy5d";
  };
in
pkgs.stdenv.mkDerivation {
  name = "ekam";
  src = ekamSrc;
  buildInputs = [ capnprotoSrc ];
  builder = ./builder.sh;

  # Make these visible as env vars in the builder:
  ekamSrc = ekamSrc;
  capnprotoSrc = capnprotoSrc;
}
