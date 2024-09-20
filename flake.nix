{
  description = "A simple Haskell project with Nix Flakes support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz"; -- Get the current unstable Nixpkgs
    #nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz"; -- Get the current stable Nixpkgs
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    #nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2405.635167.tar.gz";
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
        #devShell = pkgs.mkShell {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            haskellPackages.ghc
            haskellPackages.cabal-install
            haskellPackages.hspec                           # A Testing Framework for Haskell.
            haskellPackages.hspec-contrib                   # Contributed functionality for Hspec.
            haskellPackages.hspec-discover                  # Automatically discover and run Hspec tests.
            haskellPackages.ormolu                          # A formatter for Haskell source code.
                                                            # ormolu --mode inplace $(find . -name '*.hs')
            haskellPackages.fourmolu                        # A formatter for Haskell source code.
            haskellPackages.hlint                           # a tool that provides suggestions for improving your Haskell code.
            haskellPackages.ghcid                           # a GHCi-based development tool that provides features like code completion and type checking.
                                                            # ghcid -c "cabal repl"
            haskellPackages.hoogle                          # a search engine for Haskell documentation; Haskell API search.
            haskellPackages.haskell-language-server         # LSP server for GHC. The Haskell Language Server can be used with Neovim (or other editors) for features like auto-completion, type information, and more.
            ripgrep #ripgrep-all                            # Utility that combines the usability of The Silver Searcher with the raw speed of grep.
            neovim
            cowsay

            #jupyternotebook+ihaskel    # https://github.com/IHaskell/IHaskelll
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
          format = pkgs.runCommand "check-format" {
            buildInputs = [ pkgs.ormolu ];
          } ''
            ormolu --mode check $(find ${./.} -name '*.hs')
            touch $out
          '';

          #lint = flake-utils.lib.checkNikLint;              # ...
          lint = pkgs.runCommand "check-lint" {
            buildInputs = [ pkgs.hlint ];
          } ''
            hlint ${./.}
            touch $out
          '';

        };

      }
    );
}
