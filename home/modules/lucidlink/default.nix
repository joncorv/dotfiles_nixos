{
  lib,
  stdenv,
  dpkg,
  ar,
  tar,
  gzip,
}:

stdenv.mkDerivation {
  pname = "lucidlink";
  version = "2.9.7426"; # Update when you refresh the .deb

  src = ./lucid_2.9.7246_amd64.deb; # update package name too
  # src = ./lucid_${version}_amd64.deb;

  nativeBuildInputs = [
    dpkg
    ar
    tar
    gzip
  ];

  unpackPhase = ''
    ar x $src
    tar xzf data.tar.gz
  '';

  installPhase = ''
    mkdir -p $out
    cp -r usr/* $out/
  '';

  meta = {
    description = "LucidLink filesystem client";
    platforms = [ "x86_64-linux" ];
  };
}
