{ compiler ? "ghc883"
, sources ? import ./nix/sources.nix
}:

let
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
        cabal2nix
        ghcid
        hlint
        niv
        ormolu
        pkgs.cacert
        pkgs.nix
      ];
      #withHoogle = true;
    };
  }
