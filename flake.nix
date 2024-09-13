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
          #overlays = [
          #  (self: super: {
          #    #my-haskell-project = super.haskellPackages.callCabal2nix "my-haskell-project" (self.flake) {};
          #    my-haskell-project = super.haskellPackages.callCabal2nix "my-haskell-project" ./app {};
          #  })
          #];
        };

        # Define a custom derivation
        #myHaskellProject = pkgs.haskellPackages.mkDerivation {
        #  pname = "my-haskell-project";
        #  version = "0.1.0.0";
        #  src = ./app;
        #
        #  # Add the required license field
        #  license = pkgs.lib.licenses.mit;
        #
        #  # Overriding the build phase to use cabal build
        #  buildPhase = ''
        #    cabal configure
        #    cabal build
        #  '';
        #
        #  installPhase = ''
        #    mkdir -p $out/bin
        #    cp -r dist-newstyle/build/*/*/*/build/my-haskell-project/my-haskell-project $out/bin/
        #  '';
        #};

        # Define the Haskell project using callCabal2nix
        #myHaskellProject = pkgs.haskellPackages.callCabal2nix "my-haskell-project" ./app {};
        myHaskellProject = pkgs.haskellPackages.callCabal2nix "my-haskell-project" ./. {};

      in
      {

        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.haskellPackages.ghc
            pkgs.haskellPackages.cabal-install
          ];
        };

        # when we build with 'nix build'
        #defaultPackage = pkgs.my-haskell-project;
        defaultPackage = myHaskellProject;
        # and then run it with 'nix run'

      }
    );
}
