{ compiler ? "ghc865"
, pkgs ? import ./pkgs.nix
}:

pkgs.haskell.packages.${compiler}.callPackage ./timetrack-cli.nix { }
