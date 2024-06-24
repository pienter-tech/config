include .env
export

karabiner-build:
	cd ./karabiner/karabiner-config/ && yarn build
.PHONY: karabiner-build

