let
  pkgs = import <nixpkgs> {};
  stdenv = pkgs.stdenv;

  sparkle = import ./sparkle {
    inherit stdenv;
    bundlerEnv = pkgs.bundlerEnv;
    ruby_2_2 = pkgs.ruby_2_2;
    bundler = pkgs.bundler;
  };
in rec {
  shoutcast = stdenv.mkDerivation rec {
    name = "shoutcast-example";
    version = "0.1";

    src = ./.;

    buildInputs = [
      sparkle
    ];

    buildCommand = ''
      cp -r "$src" "$out"
    '';

    shellHook = ''
      export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
    '';
  };
}
