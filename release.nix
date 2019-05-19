{ compiler ? "ghc865"
, pkgs ? import ./pkgs.nix
}:

let
  config = {
    packageOverrides = pkgs: rec {
      haskell = pkgs.haskell // {
        packages = pkgs.haskell.packages // {
          "${compiler}" = pkgs.haskell.packages."${compiler}".override {
            overrides = haskellPackagesNew: haskellPackagesOld: rec {
              project = haskellPackagesNew.callPackage ./project.nix { };
            };
          };
        };
      };
    };
  };

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
    project = haskellPackages.project;
    haskellPackages = haskellPackages;
  }
