{ pkgs ? import <nixpkgs> {} }:
let
  ekamSrc = pkgs.fetchFromGitHub {
    owner = "capnproto";
    repo = "ekam";
    # Master as of 2021-05-16
    rev = "e450aaa45956ac0aff0220b0c22c815ea77e8553";
    sha256 = "08b196k97rr126pz8ch6wbf4frlyydilpjyin41pwh844cj7ri14";
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
