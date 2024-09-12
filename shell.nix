{
  callPackage,
  ghc,
  cabal-install,
  #...
}: let
  mainPkg = callPackage ./default.nix {};
in
  mainPkg.overrideAttrs (oa: {
    nativeBuildInputs = [
      #...
      ghc
      cabal-install
    ]
    ++ (oa.nativeBuildInputs or []);
  })
