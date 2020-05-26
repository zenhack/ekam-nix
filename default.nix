{ pkgs ? import <nixpkgs> {} }:
let
  ekamSrc = pkgs.fetchFromGitHub {
    owner = "capnproto";
    repo = "ekam";
    # Master as of 2020-04-15:
    rev = "8937eac2ae6120801b829398d430ff6fdd49a53b";
    sha256 = "1awmdcv0aagiqyibxfcjbwmjmvpdx5w49s610z66kj1scf7l65r3";
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
