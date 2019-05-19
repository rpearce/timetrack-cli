{ haskellPackages ? (import ./release.nix {}).haskellPackages }:

haskellPackages.shellFor {
  packages = p: with p; [
    project
  ];
  buildInputs = with haskellPackages; [
    cabal-install
    ghcid
    hlint
    stylish-haskell
  ];
  withHoogle = true;
}
