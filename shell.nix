{ compiler ? "ghc865"
, pkgs ? import ./pkgs.nix
}:

let
  haskellPackages = pkgs.haskell.packages.${compiler};
  timetrack-cli = haskellPackages.callPackage ./timetrack-cli.nix { };
in
  haskellPackages.shellFor {
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
  }
