include .env
export

karabiner-build:
	cd ./karabiner/karabiner-config/ && yarn build
.PHONY: karabiner-build

darwin-rebuild:
	cd ./nix/nix-darwin-config/ && darwin-rebuild switch --flake .
.PHONY: darwin-rebuild



