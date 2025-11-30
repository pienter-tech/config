# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This repository is a dotfiles management system for macOS development environments. It uses a custom-built Go toolchain to manage symlinks and binaries across multiple configuration domains.

Key managed applications:
- Terminal environments (zsh, wezterm, ghostty)
- Text editors (Neovim with extensive plugin ecosystem)
- File managers (Yazi with image preview support via ueberzugpp)
- Window managers (Aerospace)
- Homebrew packages and applications
- Theme configurations (Catppuccin themes across all tools)
- Claude Code and OpenCode configurations

## Architecture

### Configuration Distribution System

The repository uses three custom Go binaries (defined in `bins.json`) that work together:

1. **pienter-linker**: Creates symlinks from `links.json` mappings to user's home directory
2. **pienter-binner**: Manages binary installations from `bins.json` definitions
3. **pienter-launcher**: Application launcher utility

These tools reference source paths in this repo and symlink them to their expected system locations (e.g., `nvim/` → `~/.config/nvim`).

### Key Configuration Files

- `links.json`: Declarative mappings of `src` (in repo) → `dest` (system path)
- `bins.json`: Binary definitions with `src` (download path) and `name` (installed name)
- `.env`: Environment variables including API keys for various services (GitHub, OpenAI, Claude, etc.)
- `Makefile`: Orchestrates all installation, linking, and maintenance commands

## Repository Structure

- `aerospace/`: AeroSpace window manager config
- `brew/`: Homebrew package management (Brewfile + installation script)
- `claude/`: Claude Code configuration
  - `commands/`: Custom slash commands (commit, add-docs, review-changes)
  - `settings.json`: Claude Code settings
  - `projects/`, `agents/`, `history.jsonl`: Generated runtime data
- `fsh/`: Fast-syntax-highlighting themes
- `ghostty/`: Ghostty terminal configuration
- `nvim/`: Neovim configuration (Lazy.nvim based)
  - `lua/pienter/`: Core customizations (keymaps, LSP, autocmds, user commands)
  - `lua/plugins/`: ~35 plugin configurations
  - Supports project-specific snippets via `.nvim/snippets/` directories
- `obsidian/`: Obsidian vim keybindings
- `opencode/`: OpenCode CLI configuration with MCP integrations
- `raycast/`: Raycast automation scripts
- `ueberzugpp/`: Image rendering for terminal (used by Yazi)
- `wezterm/`: WezTerm terminal configuration
- `yazi/`: Yazi file manager configuration
- `zsh/`: Shell environment (zshrc, zshenv, themes)

## Common Commands

All commands are defined in the `Makefile` and require environment variables from `.env`.

### Initial Setup

```bash
# Full setup flow (run once on new machine)
make brew              # Install/update Homebrew
make brew-install      # Install all packages from Brewfile
make pienter-binner    # Install custom Go binaries
make pienter-linker    # Create all symlinks from links.json
```

### Development Workflow

```bash
# After modifying config files
make pienter-linker    # Re-link changed configurations

# After modifying bins.json
make pienter-binner    # Reinstall/update binaries

# Launch application selector
make pienter-launcher
```

### Maintenance

```bash
# Homebrew maintenance
make brew-doctor       # Diagnose Homebrew issues
make brew-cleanup      # Remove unused packages and cleanup cache

# Performance debugging
make profile-zshrc     # Profile zsh startup time with ZPROF=1
```

### Karabiner (if present)

```bash
make karabiner-build   # Build TypeScript Karabiner config
```

## Claude Code Integration

This repository includes Claude Code configuration in the `claude/` directory:

### Custom Slash Commands

- `/commit`: Creates conventional commits (feat:, fix:, docs:, etc.) using git commands
- `/add-docs`: Adds documentation for files
- `/review-changes`: Reviews recent changes and commits

These commands are defined in `claude/commands/*.md` with frontmatter specifying:
- `allowed-tools`: Restricted tool permissions for safety
- `model`: Specific Claude model to use
- `description`: Command purpose

### Configuration Files

- `claude/settings.json`: Claude Code preferences and settings
- Runtime data stored in `claude/projects/`, `claude/agents/`, `claude/history.jsonl`

## OpenCode Configuration

The `opencode/opencode.json` file configures:
- Theme: Catppuccin
- Model: anthropic/claude-opus-4-5
- Permission system: Git read operations auto-allowed, others require approval
- MCP integrations: Shortcut (enabled), Bitbucket, Browser, Figma, Context7 (disabled)
- API providers: OpenAI, Google/Gemini with environment variable references

## Neovim Architecture

Neovim uses Lazy.nvim for plugin management:

### Bootstrap Process (init.lua)

1. Auto-installs Lazy.nvim if missing
2. Detects project-specific snippets in `<project>/.nvim/snippets/`
3. Loads `pienter/` core modules
4. Lazy-loads plugins from `lua/plugins/`

### Core Modules (lua/pienter/)

- `remap.lua`: Custom keybindings
- `set.lua`: Vim options
- `lsp.lua`: LSP configurations
- `usercmd.lua`: Custom user commands
- `autocmd.lua`: Autocommands
- `context.lua`: Context-aware features
- `switch-case.lua`: Case switching utilities

### Plugin Organization

~35 plugins in `lua/plugins/` covering:
- LSP & completion (mason, completions)
- Navigation (telescope, leap, flash)
- UI (themes, line, ui)
- Debugging (dap, trouble, overseer)
- Git integration (git-blame)
- AI assistance (ai plugin)
- File management (filebrowser, obsidian, neorg)

## Theme System

Consistent Catppuccin theme applied across:
- Neovim (via themes plugin)
- Terminals (Wezterm, Ghostty)
- Shell (zsh with fsh themes)
- File managers (Yazi)

Theme variants available: Frappe, Latte, Macchiato, Mocha

## Important Notes

### When Modifying Configurations

1. **Always test changes locally first** - Broken configs can affect terminal/editor functionality
2. **After changing `links.json`** - Run `make pienter-linker` to update symlinks
3. **After changing Brewfile** - Run `make brew-install` to sync packages
4. **Neovim changes take effect immediately** - Config is symlinked to `~/.config/nvim`

### Security

- `.env` contains API keys and tokens - ensure it's gitignored
- OpenCode permission system restricts bash commands for safety
- Claude Code slash commands use `allowed-tools` to limit scope
