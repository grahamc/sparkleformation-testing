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
  mynixops = stdenv.mkDerivation rec {
    name = "cloudformation-for-stuff";
    version = "0.1";

   buildInputs = [
     sparkle
   ];

   shellHook = ''
     export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
   '';
  };
}
