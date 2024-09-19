{
  description = "A simple Haskell project with Nix Flakes support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
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
        #pkgs = nixpkgs.legacyPackages.${system};           # 'error: expected a derivation' when run 'nix flake show'
        #pkgs = nixpkgs.legacyPackages.x86_64-linux;

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
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            haskellPackages.ghc
            haskellPackages.cabal-install

            haskellPackages.hspec-discover
            haskellPackages.hspec
            haskellPackages.hspec-contrib
            haskellPackages.ormolu
            haskellPackages.hlint
            haskellPackages.ghcid
            haskell-language-server
            ripgrep
            neovim
            cowsay
          ];

          #PS1="$(echo $PS1 | sed 's;\\n;;g') \e[0;31m(nixdev)\e[m "
          #PS1="$(echo $PS1 | sed 's;\\n;;g' | sed 's/\]\\\$/] \e[0;31m(nixdev)\e[m \$/g') "
          shellHook = ''
            echo "---> Haskell development environment loaded! <--- flake.nix"
            echo "Available tools:"
            echo " - GHC: $(ghc --version)"
            echo " - Cabal: $(cabal --version | head -n 1)"
            echo " - Ormolu: $(ormolu --version | head -n 1)"
            echo " - HLint: $(hlint --version)"
            echo " - Ghcid: $(ghcid --version)"
            echo " - Haskell Language Server: $(haskell-language-server-wrapper --version)"
            echo "Remember to run 'cabal update' if you haven't recently!"
            PS1="$(echo $PS1 | sed 's;\\n;;g') \e[0;31m(nixdev)\e[m "
          '';
        };
        #
        # Separate the development environment configuration in shell.nix, so flake.nix file focus on the package definition
        #devShell = import ./shell.nix { pkgs = pkgs; };
        #devShells.default = import ./shell.nix { pkgs = pkgs; };

        # when we build with 'nix build'
        #defaultPackage = pkgs.my-haskell-project;
        #defaultPackage = myHaskellProject;
        packages.default = myHaskellProject;
        # and then run it with 'nix run'

        # nix run .#test1               # not work
        # nix run .#test2               # not work
        #
        # nix develop
        # cabal test test1
        # cabal test test2
        #
        # cabal test
        apps = {
        #  # nix run .#speed-functions-test                  # working
        #  # cabal test speed-functions-test                 # working
        #  #speed-functions-test = flake-utils.lib.mkApp {
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

          # test1:
          # nix flake check                                 # working
          # nix flake check .#speed-functions-test          # not working
          #speed = pkgs.haskellPackages.callCabal2nix "my-haskell-project-speed-test" ./. {};
          #speed-functions-test = pkgs.haskellPackages.callCabal2nix "my-haskell-project" ./. {};
          speed-functions-test = myHaskellProject;         # working
          #
          # XXX:
          #  nix flake check --> error
          #  nix flake check .#speed-functions-test --> error
          #speed-functions-test = pkgs.runCommand "speed-functions-test" { buildInputs = [ myHaskellProject ]; } ''
          #  ${pkgs.cabal-install}/bin/cabal test speed-functions-test
          #  touch $out
          #'';

          #format = flake-utils.lib.checkNixFormat;          # ...
          #lint = flake-utils.lib.checkNikLint;              # ...

        };

      }
    );
}
