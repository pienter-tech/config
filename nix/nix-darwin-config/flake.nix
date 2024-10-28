{
  description = "Korneel's MacOs Setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
  }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."korneel" = nix-darwin.lib.darwinSystem {
      modules = [./config.nix];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."korneel".pkgs;
  };
}
