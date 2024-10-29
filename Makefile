include .env
export

karabiner-build:
	cd ./karabiner/karabiner-config/ && yarn build
.PHONY: karabiner-build

nix-install:
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
.PHONY: nix-install

nix-darwin-rebuild:
	cd ./nix/nix-darwin-config/ && darwin-rebuild switch --flake .
.PHONY: nix-darwin-rebuild

# Refresh starship config
starship:
   export STARSHIP_CONFIG="/Users/korneel/.config/starship.toml"
.PHONY: starship



