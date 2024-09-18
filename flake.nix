{
  description = "A simple Haskell project with Nix Flakes support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    #flake-utils.lib.eachDefaultSystem (system:
    flake-utils.lib.eachSystem [
      "x86_64-linux"
      #"aarch64-linux"
    ] (system:
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
        #devShell = import ./shell.nix { pkgs = pkgs; };
        devShells.default = import ./shell.nix { pkgs = pkgs; };

        # when we build with 'nix build'
        #defaultPackage = pkgs.my-haskell-project;
        #defaultPackage = myHaskellProject;
        packages.default = myHaskellProject;
        # and then run it with 'nix run'

        # nix run .#test1
        # nix run .#test2
        #
        # nix develop
        # cabal test test1
        # cabal test test2
        #
        # cabal test
        apps = {

          # nix run .#speed-functions-test
          # cabal test speed-functions-test
          speed-functions-test = flake-utils.lib.mkApp {
            drv = pkgs.writeShellScriptBin "run-test1" ''
              ${pkgs.cabal-install}/bin/cabal test speed-functions-test
            '';
          };

        };

        # XXX: ???
        # Define test using the 'checks' attribute for testing
        # nix flake check
        # nix flake check .#test1
        # nix flake check .#test2
        checks = {

          # nix flake check .#speed-functions-test
          #speed = pkgs.haskellPackages.callCabal2nix "my-haskell-project-speed-test" ./. {};
          speed = pkgs.haskellPackages.callCabal2nix "speed-functions-test" ./. {};

        };

      }
    );
}
