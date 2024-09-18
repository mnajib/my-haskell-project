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
        #pkgs = nixpkgs.legacyPackages.${system};

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

        #haskellPackages = pkgs.haskellPackages;

        # Define the Haskell project using callCabal2nix
        #myHaskellProject = pkgs.haskellPackages.callCabal2nix "my-haskell-project" ./app {};
        myHaskellProject = pkgs.haskellPackages.callCabal2nix "my-haskell-project" ./. {};
        #myHaskellProject = haskellPackages.callCabal2nix "my-haskell-project" ./. {};

      in
      {

        #devShell = pkgs.mkShell {
        #  buildInputs = [
        #    pkgs.haskellPackages.ghc
        #    pkgs.haskellPackages.cabal-install
        #    pkgs.neovim
        #    pkgs.haskell-language-server
        #    pkgs.haskellPackages.ormolu
        #    pkgs.ripgrep
        #    pkgs.cowsay
        #  ];
        #};
        #
        #devShell = pkgs.mkShell {
        #  buildInputs = with pkgs; [
        #    haskellPackages.ghc
        #    haskellPackages.cabal-install
        #    neovim
        #    haskell-language-server
        #    haskellPackages.ormolu
        #    ripgrep
        #    cowsay
        #  ];
        #};
        #
        # Separate the development environment configuration in shell.nix, so flake.nix file focus on the package definition
        devShell = import ./shell.nix { pkgs = pkgs; };

        # when we build with 'nix build'
        #defaultPackage = pkgs.my-haskell-project;
        defaultPackage = myHaskellProject;
        # and then run it with 'nix run'

        # nix run .#test
        apps.test = flake-utils.lib.mkApp {
          drv = pkgs.writeShellScriptBin "" ''
            ${pkgs.cabal-install}/bin/cabal test
          '';
        };

        # XXX: ???
        # Define test using the 'checks' attribute for testing
        # nix flake check
        checks = {
          speed = pkgs.haskellPackages.callCabal2nix "my-haskell-project-speed-test" ./. {};
        };

      }
    );
}
