{
  description = "Dev shell with Python 3 and pip packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        python = pkgs.python3.withPackages (ps: with ps; [
          # fill in your pip packages here, e.g.:
          # requests
          # numpy
          cfengine
          cfbs
          cf-remote
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [ python ];
        };
      });
}
