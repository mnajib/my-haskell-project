{ pkgs ? import <nixpkgs> {} }:
(pkgs.haskellPackages.mkDerivation {
  pname = "my-haskell-project";
  version = "0.1.0";
  src = ./.;

  buildInputs = [
    pkgs.haskellPackages.cabal-install
  ];

  buildPhase = ''
    cabal build
  '';
})

