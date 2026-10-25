{ config, pkgs, lib, ... }:

let
  # 1. Beaker C Web Framework Dependency
  beaker = pkgs.stdenv.mkDerivation {
    pname = "beaker";
    version = "unstable";

    src = pkgs.fetchFromCodeberg {
      owner = "gabrielf";
      repo = "beaker";
      rev = "master";
      hash = "sha256-Al/BE7uVRSmUGF/t1m0pWxF9jNgzdCVUrc5ZHkcPiQg=";
    };

    # Default buildPhase runs `make`, which builds build/libbeaker.{so,a}.
    installPhase = ''
      runHook preInstall
      mkdir -p $out/include $out/lib
      cp beaker.h $out/include/
      cp build/libbeaker.so build/libbeaker.a $out/lib/
      runHook postInstall
    '';
  };

  # 2. Omnisarch Metasearch Engine
  omnisarch = pkgs.stdenv.mkDerivation {
    pname = "omnisarch";
    version = "unstable-2026";

    src = pkgs.fetchFromCodeberg {
      owner = "gabrielf";
      repo = "omnisearch";
      rev = "master";
      hash = "sha256-PWT4tezp99dc5OJh+qxt5AoGyQo5FoNaP/JWgFQwvjU=";
    };

    nativeBuildInputs = with pkgs; [
      pkg-config
    ];

    buildInputs = with pkgs; [
      libxml2
      curl
      openssl
      beaker
    ];

    # Patch Makefile hardcoded FHS paths and git-based versioning
    postPatch = ''
      substituteInPlace Makefile \
        --replace-warn "-I/usr/include/libxml2" "-I${pkgs.libxml2.dev}/include/libxml2" \
        --replace-warn 'git describe --tags --exact-match HEAD' 'echo "v0.1.0"' \
        --replace-warn 'git describe' 'echo "v0.1.0"'
    '';

    NIX_CFLAGS_COMPILE = toString [
      "-I${beaker}/include"
      "-I${pkgs.libxml2.dev}/include/libxml2"
    ];

    NIX_LDFLAGS = toString [
      "-L${beaker}/lib"
    ];

    # The Makefile outputs bin/omnisearch
    installPhase = ''
      runHook preInstall
      install -Dm755 bin/omnisearch $out/bin/omnisarch
      mkdir -p $out/share/omnisarch
      cp -r static templates $out/share/omnisarch/
      runHook postInstall
    '';
  };
in
{
  environment.systemPackages = [ omnisarch ];

  systemd.services.omnisarch = {
    description = "Omnisarch C Metasearch Engine";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${omnisarch}/bin/omnisarch";
      WorkingDirectory = "${omnisarch}/share/omnisarch";
      Restart = "always";
      User = "nobody";
      Group = "nogroup";
    };
  };
}
