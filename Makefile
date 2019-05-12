build:
	nix-build --attr project release.nix

cabal:
	nix-shell --pure -p cabal2nix --run "cabal2nix ." > project.nix

repl:
	nix-shell --pure --run "cabal new-repl"

run:
	result/bin/timetrack-cli

test:
	nix-shell --pure --run "cabal new-test all"
