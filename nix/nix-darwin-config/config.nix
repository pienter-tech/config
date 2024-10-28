{pkgs, ...}: {
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
    pkgs.raycast
    pkgs.karabiner-elements # handles keyboard shortcuts
    pkgs.alejandra # nix formatter
    pkgs.bat
    pkgs.fd
    pkgs.fswatch # watch files and run commands in response
    pkgs.fzf
    pkgs.starship
  ];

  fonts.packages = [
    (
      pkgs.nerdfonts.override {fonts = ["FiraCode" "RobotoMono" "JetBrainsMono"];}
    )
  ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # enable touch id in terminal
  security.pam.enableSudoTouchIdAuth = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.autohide-time-modifier = 0.0;
  system.defaults.dock.launchanim = false;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.AppleShowAllFiles = true;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.ShowStatusBar = true;
}
