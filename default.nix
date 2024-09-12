{
  stdenv,
  ghc,
  cabal-install,
}:
stdenv.mkDerivation {
  buildInputs = [
    ghc
    cabal-install
  ];
  name = "najib-haskell-packages";
  version = "0.0.1";
  src = ./.;
}
