build:
	nix-build

cabal:
	nix-shell --pure -p cabal2nix --run "cabal2nix ." > project.nix

repl:
	nix-shell --pure --run "cabal new-repl"

# run is intended for quick testing.
# to pass arguments while developing,
# do so like this:
#
# result/bin/timetrack-cli add 2019-05-13 "blah blah +5.0"
run:
	result/bin/timetrack-cli

test:
	nix-shell --pure --run "cabal new-test all"

update_nixpkgs:
	nix-shell --pure --run "niv update nixpkgs"
