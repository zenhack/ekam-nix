{ pkgs ? import <nixpkgs> {} }:
let
  ekamSrc = pkgs.fetchFromGitHub {
    owner = "capnproto";
    repo = "ekam";
    # Master as of 2021-09-04
    rev = "dc414bbdb4f0164c196dc91921ad27241efaa0cc";
    sha256 = "0akmxrsfxzb8i9xps8iwajzqbh0bxcr0whca10lk4b23lq1zyvhi";
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
