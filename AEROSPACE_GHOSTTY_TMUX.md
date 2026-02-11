# Aerospace + Ghostty + Tmux Integration Guide

Complete setup for using Ghostty with tmux in the Aerospace tiling window manager.

## Overview

Your setup now consists of:
- **Aerospace** - macOS tiling window manager
- **Ghostty** - GPU-accelerated terminal emulator (borderless for clean tiling)
- **tmux** - Terminal multiplexer (replaces WezTerm's built-in multiplexer)

## Configuration Changes

### Ghostty (Optimized for Aerospace)

```ini
# Borderless windows for clean tiling
window-decoration = false

# Non-native fullscreen (works better with tiling WMs)
macos-non-native-fullscreen = true

# Optional: Hide traffic light buttons completely
# macos-window-buttons = hidden
```

**Why these settings?**
- `window-decoration = false` - No titlebar = maximum screen space + clean tiling
- `macos-non-native-fullscreen = true` - Fullscreen stays in Aerospace workspace (doesn't create new space)
- No traffic lights needed since Aerospace manages windows via keyboard

### Aerospace (Auto-route Ghostty to workspace 'd')

```toml
[[on-window-detected]]
if.app-id = 'com.mitchellh.ghostty'
check-further-callbacks = false
run = 'move-node-to-workspace d'
```

This automatically moves all Ghostty windows to workspace `d` (same as WezTerm).

## Workflow

### Starting Your Day

```bash
# 1. Aerospace automatically routes Ghostty to workspace 'd'
# 2. Launch Ghostty (it opens borderless)
# 3. Start tmux
tmux

# 4. Or use project selector
# Press: Alt+P (in tmux)
```

### Window Management

**Aerospace handles window-level operations:**
- `Alt+Cmd+Ctrl+H/J/K/L` - Focus windows
- `Alt+Cmd+Ctrl+Shift+H/J/K/L` - Move windows
- `Alt+Cmd+Ctrl+D` - Go to workspace 'd' (dev/terminal)
- `Alt+Cmd+Ctrl+0` - Fullscreen current window

**tmux handles pane-level operations:**
- `Ctrl+H/J/K/L` - Navigate panes (vim-aware)
- `Ctrl+Shift+H/J/K/L` - Resize panes (vim-aware)
- `Prefix+H/J/K/L` - Split panes
- `Prefix+Z` - Zoom pane

### Multi-Monitor Setup

Your Aerospace config routes workspace `d` to specific monitors:

```toml
[workspace-to-monitor-force-assignment]
d = ['GW2765', 'P2415Q', 'LG HDR 4K', 'PHL 346E2C']
```

Ghostty windows will automatically appear on these monitors.

## Keybinding Layers

Understanding the three layers of control:

### Layer 1: Aerospace (Window Manager)
Controls **entire windows** and **workspaces**

```
Alt+Cmd+Ctrl+H/J/K/L       Navigate between windows
Alt+Cmd+Ctrl+Shift+H/J/K/L Move windows
Alt+Cmd+Ctrl+D             Go to workspace 'd'
Alt+Cmd+Ctrl+0             Fullscreen
Alt+Cmd+Ctrl+=/−           Resize windows
```

### Layer 2: tmux (Terminal Multiplexer)
Controls **panes** and **sessions** within a Ghostty window

```
Prefix (§)                 Leader key
Alt+P                      Project selector
Ctrl+H/J/K/L              Navigate panes (vim-aware)
Ctrl+Shift+H/J/K/L        Resize panes (vim-aware)
Prefix+H/J/K/L            Split panes
Prefix+Z                  Zoom pane
Prefix+C                  Close pane
```

### Layer 3: Ghostty (Terminal Emulator)
Controls **terminal-level** features

```
Super+N                    New Ghostty window
Super+W                    Close Ghostty window
Super+Shift+R              Reload config
Super+,                    Open config
Super+K                    Clear screen
Super+C/V                  Copy/Paste
Super+0/+/−                Font size
```

## Common Workflows

### Workflow 1: Single Project, Multiple Panes

```bash
# 1. Open project selector
Alt+P

# 2. Select your project (creates tmux session)
# Type to search, Enter to select

# 3. Split into panes
Prefix+L    # Split right (editor)
Prefix+J    # Split down (terminal)

# 4. Navigate with Ctrl+H/J/K/L
# 5. Zoom focused pane with Prefix+Z
```

Result:
```
┌─────────────────────────────────────┐
│ Editor (nvim)    │ Logs/Server      │
│                  │                  │
│                  ├──────────────────┤
│                  │ Terminal         │
└─────────────────────────────────────┘
```

### Workflow 2: Multiple Projects, Multiple Windows

```bash
# 1. Open project 1
Alt+P → Select "pienter__config"

# 2. Open new Ghostty window (Aerospace will tile it)
Super+N

# 3. In new window, open project 2
Alt+P → Select "tnt__dry"

# 4. Navigate between windows with Aerospace
Alt+Cmd+Ctrl+H/L
```

Result: Two Ghostty windows, each with different tmux session, tiled by Aerospace

### Workflow 3: Dedicated Monitor for Development

```bash
# Your Aerospace config already routes workspace 'd' to specific monitors
# Just go to workspace 'd' and all Ghostty windows appear there

Alt+Cmd+Ctrl+D    # Go to dev workspace
Alt+P             # Open project
```

## Tips & Tricks

### 1. Borderless Window Benefits

**With `window-decoration = false`:**
- ✅ No titlebar wasting vertical space
- ✅ Clean, minimal aesthetic
- ✅ Perfect tiling with no gaps
- ✅ Aerospace manages everything via keyboard

**How to close windows without titlebar:**
- `Super+W` - Close Ghostty window
- `Prefix+D` - Detach from tmux (keeps session running)
- `Alt+Cmd+Ctrl+Backspace` - Aerospace close window (in service mode)

### 2. Fullscreen in Aerospace

```bash
# Toggle fullscreen (stays in workspace)
Alt+Cmd+Ctrl+0

# This is better than macOS native fullscreen which creates a new space
```

### 3. Project Persistence

tmux sessions persist even when you:
- Close Ghostty windows
- Switch workspaces
- Restart Ghostty

```bash
# List running sessions
tmux ls

# Attach to existing session
tmux attach -t session-name

# Or use project selector (shows active sessions with *)
Alt+P
```

### 4. Multiple Ghostty Windows, Same Session

You can attach multiple Ghostty windows to the same tmux session:

```bash
# Window 1
tmux attach -t myproject

# Window 2 (new Ghostty window)
tmux attach -t myproject

# Both windows show the same session!
# Great for multi-monitor setups
```

### 5. Aerospace Modes

Your Aerospace has special modes:

**Service Mode** (`Alt+Cmd+Ctrl+;`):
- `R` - Reset layout
- `F` - Toggle floating
- `Backspace` - Close all but current
- `Esc` - Reload config

**Arrange Mode** (`Alt+Cmd+Ctrl+'`):
- `=` - Balance sizes
- `Alt+Shift+Cmd+Ctrl+J/K` - Move workspace to monitor

### 6. Quick Window Switching

```bash
# Aerospace workspace switching
Alt+Cmd+Ctrl+Tab    # Back and forth between last two workspaces

# tmux session switching
Alt+S               # Session chooser
Alt+P               # Project selector (with search)
```

## Troubleshooting

### Ghostty Windows Not Tiling Properly

**Check Aerospace config:**
```bash
# Verify Ghostty is configured
grep -A2 "com.mitchellh.ghostty" ~/.config/aerospace/aerospace.toml
```

**Should show:**
```toml
[[on-window-detected]]
if.app-id = 'com.mitchellh.ghostty'
check-further-callbacks = false
run = 'move-node-to-workspace d'
```

**Reload Aerospace:**
```bash
# In Aerospace service mode
Alt+Cmd+Ctrl+;
Esc  # Reloads config
```

### Titlebar Still Showing

**Check Ghostty config:**
```bash
grep "window-decoration" ~/.config/ghostty/config
```

**Should show:**
```ini
window-decoration = false
```

**Reload Ghostty:**
```bash
Super+Shift+R
```

### Traffic Light Buttons Visible

If you want to hide them completely:

```ini
# In ghostty/config
macos-window-buttons = hidden
```

Then reload: `Super+Shift+R`

### Fullscreen Creates New macOS Space

**Check Ghostty config:**
```bash
grep "macos-non-native-fullscreen" ~/.config/ghostty/config
```

**Should be:**
```ini
macos-non-native-fullscreen = true
```

### Can't Close Windows

Without titlebar, use:
- `Super+W` - Close Ghostty window
- `Prefix+D` - Detach tmux (keeps session)
- Service mode → `Backspace` - Close all but current

## Comparison: WezTerm vs Ghostty+tmux+Aerospace

| Feature | WezTerm | Ghostty+tmux+Aerospace |
|---------|---------|------------------------|
| Window tiling | Manual/external WM | Aerospace (automatic) |
| Pane splits | Built-in | tmux |
| Project selector | Lua script | Shell script + fzf |
| Session persistence | No | Yes (tmux) |
| Borderless windows | Configurable | Optimized for tiling |
| Multi-monitor | Manual | Aerospace auto-routing |
| Workspace switching | Built-in | Aerospace + tmux |
| Vim integration | Lua | tmux + Neovim |

## Advanced: Aerospace Layouts

### Tiles Layout (Default)
```
┌─────────┬─────────┐
│         │         │
│    1    │    2    │
│         │         │
├─────────┼─────────┤
│         │         │
│    3    │    4    │
│         │         │
└─────────┴─────────┘
```

### Accordion Layout
```
┌─────────────────────┐
│         1           │
├─────────────────────┤
│         2           │
├─────────────────────┤
│         3           │
└─────────────────────┘
```

**Switch layouts:**
```bash
Alt+Cmd+Ctrl+/      # Toggle tiles horizontal/vertical
Alt+Cmd+Ctrl+,      # Toggle accordion horizontal/vertical
```

## Recommended Aerospace Tweaks for Ghostty

Add to your `aerospace.toml`:

```toml
# Optional: Make Ghostty windows always tile (never float)
[[on-window-detected]]
if.app-id = 'com.mitchellh.ghostty'
run = ['layout tiling']

# Optional: Specific layout for workspace 'd'
# (Uncomment if you want a specific default layout)
# [[on-workspace-detected]]
# if.workspace = 'd'
# run = ['layout tiles horizontal']
```

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────┐
│ Aerospace + Ghostty + tmux Quick Reference              │
├─────────────────────────────────────────────────────────┤
│ AEROSPACE (Window Manager)                              │
│   Alt+Cmd+Ctrl+H/J/K/L    Navigate windows              │
│   Alt+Cmd+Ctrl+Shift+H/J/K/L  Move windows              │
│   Alt+Cmd+Ctrl+D          Go to dev workspace           │
│   Alt+Cmd+Ctrl+0          Fullscreen                    │
│   Alt+Cmd+Ctrl+=/−        Resize windows                │
├─────────────────────────────────────────────────────────┤
│ TMUX (Multiplexer) - Prefix: §                          │
│   Alt+P                   Project selector              │
│   Ctrl+H/J/K/L           Navigate panes                 │
│   Ctrl+Shift+H/J/K/L     Resize panes                   │
│   Prefix+H/J/K/L         Split panes                    │
│   Prefix+Z               Zoom pane                      │
├─────────────────────────────────────────────────────────┤
│ GHOSTTY (Terminal)                                      │
│   Super+N                New window                     │
│   Super+W                Close window                   │
│   Super+Shift+R          Reload config                  │
└─────────────────────────────────────────────────────────┘
```

## Summary

Your new setup gives you:

✅ **Aerospace** - Automatic window tiling and workspace management  
✅ **Ghostty** - Fast, borderless terminal optimized for tiling  
✅ **tmux** - Persistent sessions and pane management  
✅ **Project selector** - Quick switching with `.wakatime-project` auto-discovery  
✅ **Vim-aware navigation** - Seamless movement between Neovim and tmux  
✅ **Multi-monitor** - Automatic workspace routing  
✅ **Clean aesthetic** - No titlebars, maximum screen space  

The workflow is nearly identical to WezTerm, but with better window management and session persistence!
