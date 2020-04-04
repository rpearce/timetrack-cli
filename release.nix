{ compiler ? "ghc881" }:

let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { config = { }; };
  haskellPackages = pkgs.haskell.packages.${compiler};
  project = haskellPackages.callPackage ./project.nix { };
in
  {
    project = project;

    shell = haskellPackages.shellFor {
      packages = p: with p; [
        project
      ];
      buildInputs = with haskellPackages; [
        cabal-install
        ghcid
      ];
      withHoogle = true;
    };
  }
