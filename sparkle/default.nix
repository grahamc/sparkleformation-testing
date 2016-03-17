{ stdenv, bundler, bundlerEnv, ruby_2_2, ... }:

let
env = bundlerEnv {
  name = "sfn-2.1.10";

  ruby = ruby_2_2;
  gemfile = ./Gemfile;
  lockfile = ./Gemfile.lock;
  gemset = ./gemset.nix;
};

in stdenv.mkDerivation {
  name = "sfn";

  buildInputs = [ env bundler ];
  script = "${env}/bin/sfn";

  buildCommand = ''
    mkdir -p $out/bin
    install -D -m755 "$script" "$out/bin/sfn";
    patchShebangs "$out/bin/sfn";
  '';
}
