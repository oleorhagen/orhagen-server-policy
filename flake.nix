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

        # fill in your pip (PyPI) packages here, e.g.:
        pipPackages = [
          "cfengine"
          "cfbs"
          "cf-remote"
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.python3 ];

          shellHook = ''
            if [ ! -d .venv ]; then
              python3 -m venv .venv
            fi
            source .venv/bin/activate
            pip install --quiet ${pkgs.lib.escapeShellArgs pipPackages}
          '';
        };
      });
}
