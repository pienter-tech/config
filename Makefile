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

# Profile zsh config
profile:
	time ZPROF=1 zsh -i -c exit
.PHONY: profile

# Check if brew is installed and install it if it is not
brew:
	./brew/brew-install.sh
	brew update
	brew upgrade
.PHONY: brew

# Install all brew packages
brew-install: brew
	cd ./brew/ && brew bundle
.PHONY: brew-install





