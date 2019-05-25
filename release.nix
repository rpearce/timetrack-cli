{ compiler ? "ghc865"
, pkgs ? import ./pkgs.nix
}:

let
  config = {};

  # Pinned nixpkgs
  bootstrap = import <nixpkgs> { };
  nixpkgs = builtins.fromJSON (builtins.readFile ./nixpkgs.json);
  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo  = "nixpkgs";
    inherit (nixpkgs) rev sha256;
  };
  pkgs = import src { inherit config; };
  haskellPackages = pkgs.haskell.packages.${compiler};
in
  {
    timetrack-cli = haskellPackages.callPackage ./timetrack-cli.nix { };
    shell = haskellPackages.shellFor {
      packages = p: with p; [
        timetrack-cli
      ];
      buildInputs = with haskellPackages; [
        cabal-install
        ghcid
        hlint
        stylish-haskell
      ];
      withHoogle = true;
    };
  }
