{ pkgs ? import <nixpkgs> {} }:
let
  ekamSrc = pkgs.fetchFromGitHub {
    owner = "capnproto";
    repo = "ekam";
    # Master as of 2021-09-18
    rev = "77c338f8bd8f4a2ce1e6199b2a52363f1fccf388";
    sha256 = "0q4bizlb1ykzdp4ca0kld6xm5ml9q866xrj3ijffcnyiyqr51qr8";
  };
  capnprotoSrc = pkgs.fetchFromGitHub {
    owner = "capnproto";
    repo = "capnproto";
    rev = "v0.9.0";
    sha256 = "038i40apywn8sg95kwld4mg9p9m08izcw5xj7mwkmshycmqw65na";
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

  meta = with pkgs.lib; {
    description = ''Build system ("make" in reverse)'';
    longDescription = ''Ekam ("make" spelled backwards) is a build system which automatically figures out what to build and how to build it purely based on the source code. No separate "makefile" is needed.'';
    homepage = "https://github.com/capnproto/ekam";
    license = licenses.asl20;
    platforms = platforms.linux;
  };
}
