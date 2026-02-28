{ pkgs, ... }:
{
  # Development packages
  home.packages = with pkgs; [
    # C/C++
    clang

    # Rust
    cargo
    rustc

    # Haskell
    ghc
    haskellPackages.cabal-install
  ];
}
