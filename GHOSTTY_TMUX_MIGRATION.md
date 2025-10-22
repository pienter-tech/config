# Ghostty + Tmux Migration Guide

This guide documents the migration from WezTerm to Ghostty + tmux, replicating your existing workflow.

## Overview

- **Terminal Emulator**: WezTerm → Ghostty
- **Multiplexer**: WezTerm built-in → tmux
- **Project Selector**: WezTerm Lua workspace selector → tmux session selector with fzf

## Installation

### Prerequisites

```bash
# Install Ghostty (if not already installed)
brew install --cask ghostty

# Install tmux
brew install tmux

# Install fzf (required for project selector)
brew install fzf
```

### Setup

The configuration files are already in place:

- **Ghostty config**: `~/.config/ghostty/config`
- **Tmux config**: `~/.config/tmux/tmux.conf`
- **Project selector**: `~/.config/tmux/scripts/tmux-project-selector`

## Key Differences from WezTerm

### Prefix Key

Tmux uses a "prefix" key for commands (like WezTerm's leader key):

- **Prefix**: `§` (same as WezTerm leader)
- Press prefix, then the command key

### Sessions vs Workspaces

- **WezTerm workspaces** → **tmux sessions**
- Each project gets its own tmux session
- Sessions persist even when you close Ghostty

## Keybindings

### Project Selection

| Action | WezTerm | Ghostty + Tmux |
|--------|---------|----------------|
| Open project selector | `Super+L` | `Alt+L` |
| Switch sessions | `Ctrl+Tab` | `Alt+S` |

**Project Selector Features:**
- Auto-discovers projects with `.wakatime-project` files
- Shows active sessions with `*` marker
- Fuzzy search with fzf
- Preview project contents
- `Ctrl+R` to rebuild cache
- `Ctrl+/` to toggle preview

### Window Management (Tabs)

| Action | WezTerm | Ghostty + Tmux |
|--------|---------|----------------|
| New window/tab | `Prefix+t, n` | `Alt+T` |
| Close window/tab | `Prefix+t, c` | `Prefix+T` |
| Last window/tab | `Prefix+t, t` | `Prefix+Tab` |
| Go to window 1-9 | - | `Alt+1` to `Alt+9` |

### Pane Management (Splits)

| Action | WezTerm | Ghostty + Tmux |
|--------|---------|----------------|
| Split left | `Prefix+w, h` | `Prefix+H` |
| Split down | `Prefix+w, j` | `Prefix+J` |
| Split up | `Prefix+w, k` | `Prefix+K` |
| Split right | `Prefix+w, l` | `Prefix+L` |
| Split right (25%) | `Prefix+w, s` | `Prefix+S` |
| Close pane | `Prefix+w, c` | `Prefix+C` |
| Rotate panes | `Prefix+w, w/W` | `Prefix+W/Shift+W` |
| Zoom pane | `Prefix+z` | `Prefix+Z` |

### Navigation (Vim-aware)

| Action | Keybinding |
|--------|------------|
| Navigate left | `Ctrl+H` |
| Navigate down | `Ctrl+J` |
| Navigate up | `Ctrl+K` |
| Navigate right | `Ctrl+L` |

**Note**: These work seamlessly between Neovim splits and tmux panes!

### Resizing (Vim-aware)

| Action | Keybinding |
|--------|------------|
| Resize left | `Ctrl+Shift+H` |
| Resize down | `Ctrl+Shift+J` |
| Resize up | `Ctrl+Shift+K` |
| Resize right | `Ctrl+Shift+L` |

### Copy Mode (Vi-style)

| Action | Keybinding |
|--------|------------|
| Enter copy mode | `Prefix+[` |
| Start selection | `v` (in copy mode) |
| Copy selection | `y` (in copy mode) |
| Paste | `Prefix+]` |
| Rectangle selection | `Ctrl+V` (in copy mode) |

### Ghostty-specific

| Action | Keybinding |
|--------|------------|
| Reload config | `Super+Shift+R` |
| New Ghostty window | `Super+N` |
| Close window | `Super+W` |
| Increase font size | `Super++` |
| Decrease font size | `Super+-` |
| Reset font size | `Super+0` |
| Open config | `Super+,` |
| Toggle fullscreen | `Super+Ctrl+F` |

### Tmux-specific

| Action | Keybinding |
|--------|------------|
| Reload tmux config | `Prefix+R` |
| Detach from session | `Prefix+D` |
| Clear screen | `Prefix+Ctrl+L` |

## Workflow

### Starting a New Day

```bash
# Option 1: Start Ghostty, then launch tmux
ghostty
tmux

# Option 2: Auto-start tmux (uncomment in ghostty config)
# command = /bin/zsh -c "tmux new-session -A -s main"

# Option 3: Use project selector
# Press Alt+L, select your project
```

### Working with Projects

1. **Open project selector**: `Alt+L`
2. **Search** for your project (fuzzy search)
3. **Press Enter** to create/switch to session
4. **Active sessions** are marked with `*`

### Switching Between Projects

- **Quick switch**: `Alt+S` (choose from list)
- **Project selector**: `Alt+L` (with search)

### Managing Panes

```bash
# Create a split layout
Prefix+L          # Split right
Prefix+J          # Split down in left pane
Ctrl+H/J/K/L      # Navigate between panes
Prefix+Z          # Zoom current pane
```

### Detaching and Reattaching

```bash
# Detach from session (keeps it running)
Prefix+D

# List sessions
tmux ls

# Attach to session
tmux attach -t session-name

# Or use project selector
Alt+L
```

## Project Discovery

Projects are auto-discovered by scanning for `.wakatime-project` files in:

- `~/Obsidian`
- `~/dev/projects`

The content of `.wakatime-project` is used as the session name.

### Cache Management

- Projects are cached for 1 hour
- **Rebuild cache**: `Ctrl+R` in project selector
- **Manual rebuild**: `tmux-project-selector --rebuild`

## Neovim Integration

Add this to your Neovim config for seamless tmux navigation:

## Theme

Both Ghostty and tmux auto-detect macOS appearance:

- **Light mode**: Catppuccin Latte
- **Dark mode**: Catppuccin Mocha

Themes switch automatically when you change system appearance.

## Tips & Tricks

### Session Persistence

Unlike WezTerm workspaces, tmux sessions persist:

```bash
# Sessions survive:
- Closing Ghostty
- System restarts (with tmux-resurrect plugin)
- Network disconnections (when using SSH)
```

### Multiple Windows

You can have multiple Ghostty windows attached to the same session:

```bash
# In terminal 1
tmux attach -t myproject

# In terminal 2 (different Ghostty window)
tmux attach -t myproject

# Both windows show the same session!
```

### Scrollback

- **Tmux scrollback**: `Prefix+[` then use vim keys
- **Ghostty scrollback**: Mouse wheel (when not in tmux copy mode)

### Customization

Edit configurations:

```bash
# Ghostty config
ghostty --config  # or Super+,

# Tmux config
nvim ~/.config/tmux/tmux.conf
# Then reload: Prefix+R
```

## Troubleshooting

### Project selector not working

```bash
# Check if fzf is installed
which fzf

# Rebuild cache
tmux-project-selector --rebuild

# Check search paths in script
nvim ~/.config/tmux/scripts/tmux-project-selector
```

### Vim navigation not working

```bash
# Check if tmux is detecting vim
ps -o state= -o comm= -t $(tty)

# Make sure you're using the vim integration in Neovim
```

### Colors look wrong

```bash
# Check terminal type
echo $TERM  # Should be tmux-256color

# Force theme reload
~/.config/tmux/scripts/theme-switcher.sh
```

### Can't find tmux-project-selector

```bash
# Make sure it's executable
chmod +x ~/.config/tmux/scripts/tmux-project-selector

# Check PATH in tmux
tmux show-environment PATH
```

## Migration Checklist

- [ ] Install Ghostty, tmux, and fzf
- [ ] Verify configs are in place
- [ ] Test project selector (`Alt+L`)
- [ ] Add Neovim integration
- [ ] Test vim-aware navigation
- [ ] Customize keybindings if needed
- [ ] Set up auto-start tmux in Ghostty (optional)
- [ ] Install tmux plugins (optional, see tmux.conf)

## Optional Enhancements

### Tmux Plugin Manager (TPM)

Uncomment the plugin section in `tmux.conf` and install:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then in tmux: Prefix+I to install plugins
```

**Recommended plugins:**
- `tmux-resurrect`: Save/restore sessions
- `tmux-continuum`: Auto-save sessions
- `catppuccin/tmux`: Enhanced Catppuccin theme

### Auto-start tmux

Uncomment in `~/.config/ghostty/config`:

```ini
command = /bin/zsh -c "tmux new-session -A -s main"
```

This creates or attaches to a "main" session on startup.

## Resources

- [Tmux documentation](https://github.com/tmux/tmux/wiki)
- [Ghostty documentation](https://ghostty.org)
- [Catppuccin themes](https://github.com/catppuccin/catppuccin)

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────┐
│ Ghostty + Tmux Quick Reference                          │
├─────────────────────────────────────────────────────────┤
│ Prefix: §                                               │
├─────────────────────────────────────────────────────────┤
│ Projects                                                │
│   Alt+L          Project selector                       │
│   Alt+S          Session chooser                        │
│   Prefix+D       Detach session                         │
├─────────────────────────────────────────────────────────┤
│ Windows (Tabs)                                          │
│   Alt+T          New window                             │
│   Alt+1-9        Go to window 1-9                       │
│   Prefix+Tab     Last window                            │
├─────────────────────────────────────────────────────────┤
│ Panes (Splits)                                          │
│   Prefix+H/J/K/L Split left/down/up/right              │
│   Prefix+S       Split right (25%)                      │
│   Prefix+C       Close pane                             │
│   Prefix+Z       Zoom pane                              │
│   Ctrl+H/J/K/L   Navigate (vim-aware)                   │
│   Ctrl+Shift+H/J/K/L  Resize (vim-aware)               │
├─────────────────────────────────────────────────────────┤
│ Copy Mode                                               │
│   Prefix+[       Enter copy mode                        │
│   v              Start selection                        │
│   y              Copy selection                         │
│   Prefix+]       Paste                                  │
└─────────────────────────────────────────────────────────┘
```
