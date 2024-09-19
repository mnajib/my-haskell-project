# Development environment
```
cd my-haskell-project
ghc --version
nix develop
ghc --version
```

# Build and run
```
nix build
./result/bin/speed-functions-test
```

# Check and test
```
nix run .#speed-functions-test
cabal test speed-functions-test
cabal test
```

# nix flake
```
nix flake metadata
nix flake show
nix flake check
nix flake update
```

# cabal
```
cabal update
```
