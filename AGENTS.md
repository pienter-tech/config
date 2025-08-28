# AGENTS.md

## Available OpenCode Agents

### architect
Senior software architect for designing robust, scalable systems through collaborative planning. Use for system design, architecture decisions, and project structure planning.

### commit  
Creates structured commits following Conventional Commits specification with clear, professional messages. Use for creating clean, meaningful commit messages.

### review
Reviews code changes for quality, security, performance, and best practices. Use after writing significant code changes to get thorough feedback and suggestions for improvement.

## Build/Test Commands
- No traditional build system - uses Makefile for configuration management
- `make help` - Show all available commands
- `make brew-install` - Install all packages and dependencies
- `make brew-doctor` - Check system health and dependencies
- `make profile-zshrc` - Profile shell configuration performance
- No traditional tests - configuration validation through successful linking/installation

## Code Style Guidelines
- **Lua**: 4 spaces indentation, 120 column width, stylua formatting (see nvim/stylua.toml)
- **Shell**: Use `#!/bin/bash` shebang, follow existing patterns in brew/ and raycast/ scripts
- **Configuration files**: Follow existing indentation patterns (TOML, JSON, etc.)
- **File organization**: Group related configs in subdirectories (nvim/lua/plugins/, etc.)
- **Naming**: Use kebab-case for files, snake_case for Lua variables, UPPER_CASE for env vars
- **Error handling**: Use proper exit codes in shell scripts, handle missing files gracefully
- **Comments**: Use descriptive comments in complex configurations, especially for Raycast scripts
- **Dependencies**: Check Brewfile before assuming packages are available
- **Paths**: Use absolute paths via CONFIG_DIR environment variable where possible
- **Theme consistency**: Follow Catppuccin theme variants (frappe, latte, macchiato, mocha)