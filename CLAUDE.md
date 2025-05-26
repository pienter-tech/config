# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This repository contains dotfiles and configuration files for various development tools and environments. It's organized as a centralized configuration manager for:

- Terminal environments (zsh, wezterm)
- Text editors (Neovim)
- File managers (Yazi)
- Window managers (Aerospace)
- Homebrew packages and applications
- Theme configurations (Catppuccin themes)

## Repository Structure

- `aerospace/`: Window manager configuration
- `brew/`: Homebrew package management
  - `Brewfile`: Formulas, casks, and VS Code extensions
  - `brew-install.sh`: Homebrew installation script
- `fsh/`: Fast syntax highlighting themes
- `nvim/`: Neovim configuration
  - `lua/pienter/`: Core Neovim customizations
  - `lua/plugins/`: Plugin configurations
  - `lsp/`: Language server configurations
- `wezterm/`: Terminal emulator configuration
- `yazi/`: File manager configuration
- `zsh/`: Shell configurations
  - `themes/`: Shell syntax highlighting themes
  - `zshrc`: Main shell configuration
  - `zshenv`: Environment variables
- `raycast/`: Scripts for Raycast launcher

## Configuration Management

The repository uses a custom symlinking system to manage dotfiles:

- `links.json`: Maps source files/directories to their destination in the user's home directory
- `bins.json`: Manages binary executables for the configuration system

## Common Commands

### Setup and Installation

```bash
# Install and update Homebrew
make brew

# Install all Homebrew packages defined in Brewfile
make brew-install

# Link configuration files to their system locations
make pienter-linker

# Install binaries defined in bins.json
make pienter-binner

# Run the launcher application
make pienter-launcher
```

### Maintenance

```bash
# Check Homebrew for issues
make brew-doctor

# Clean up Homebrew cache and remove unused packages
make brew-cleanup

# Profile zsh configuration performance
make profile-zshrc
```

## Theme Management

The repository uses the Catppuccin theme across multiple applications with four variants:
- Frappe
- Latte
- Macchiato
- Mocha

Theme files for various applications are stored in their respective directories.