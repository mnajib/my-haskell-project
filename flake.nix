{
  description = "A simple Haskell project with Nix Flakes support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (self: super: {
              #my-haskell-project = super.haskellPackages.callCabal2nix "my-haskell-project" (self.flake) {};
              my-haskell-project = super.haskellPackages.callCabal2nix "my-haskell-project" ./app {};
            })
          ];
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.haskellPackages.ghc
            pkgs.haskellPackages.cabal-install
          ];
        };
        defaultPackage = pkgs.my-haskell-project;
      }
    );
}
