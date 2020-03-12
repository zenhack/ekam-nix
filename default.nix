{ pkgs ? import <nixpkgs> {} }:
let
  ekamSrc = pkgs.fetchFromGitHub {
    owner = "capnproto";
    repo = "ekam";
    rev = "2ff0ff164508fd25a04997881227e9cf4312f754";
    sha256 = "1529gx3jd34n1icx9dzzqpg0c0z7c9bifirq951s3d2ji4qj5nm2";
  };
  capnprotoSrc = pkgs.fetchFromGitHub {
    owner = "capnproto";
    repo = "capnproto";
    rev = "v0.7.0";
    sha256 = "0kznsmnd25gzlmba9zaziwsbblgiwc6lg3g2ibkph30gwi8dvzk3";
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
