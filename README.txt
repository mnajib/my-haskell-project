cd my-haskell-project
ghc --version
nix develop
ghc --version
nix build
./result/bin/algebra

nix flake check

cabal update

# To run test
nix build .#speed-function-test
# or
cabal test
# or
nix test
