{ pkgs }:
pkgs.mkShell {
  #buildInputs = [
  #  pkgs.haskellPackages.ghc
  #  pkgs.haskellPackages.cabal-install
  #];
  buildInputs = with pkgs; [
    #ghc
    #cabal-install
    haskellPackages.ghc
    haskellPackages.cabal-install

    neovim
    haskell-language-server             # Language Server Protocol (LSP), haskell-language-server (HLS) for intelligent code completion, error checking, and more
    haskellPackages.ormolu              # Haskell formatter
    ripgrep                             # Required for some Neovim plugins

    cowsay                              # XXX: test
  ];

  shellHook = ''
    echo "---> Haskell development environment loaded! <--- shell.nix"
  '';
}

