include .env
export

# Colors
BOLD := $(shell tput bold)
RED := $(shell tput setaf 1)
GREEN := $(shell tput setaf 2)
YELLOW := $(shell tput setaf 3)
BLUE := $(shell tput setaf 4)
MAGENTA := $(shell tput setaf 5)
CYAN := $(shell tput setaf 6)
RESET := $(shell tput sgr0)

# Helper functions
define log_info
	@echo "$(BLUE)$(BOLD)→$(RESET) $(CYAN)$(1)$(RESET)"
endef

define log_success
	@echo "$(GREEN)$(BOLD)✓$(RESET) $(GREEN)$(1)$(RESET)"
endef

define log_warning
	@echo "$(YELLOW)$(BOLD)!$(RESET) $(YELLOW)$(1)$(RESET)"
endef

define log_error
	@echo "$(RED)$(BOLD)✗$(RESET) $(RED)$(1)$(RESET)"
endef

# Default target
.DEFAULT_GOAL := help

help:
	@echo "$(BOLD)Available commands:$(RESET)"
	@echo "$(CYAN)make brew$(RESET)             - Install and update Homebrew"
	@echo "$(CYAN)make brew-install$(RESET)     - Install all Homebrew packages"
	@echo "$(CYAN)make brew-doctor$(RESET)      - Run brew doctor"
	@echo "$(CYAN)make brew-cleanup$(RESET)     - Clean up Homebrew cache"
	@echo "$(CYAN)make karabiner-build$(RESET)  - Build Karabiner configuration"
	@echo "$(CYAN)make profile-zshrc$(RESET)    - Profile zsh configuration"
	@echo "$(CYAN)make pienter-binner$(RESET)   - Run pienter-binner"
	@echo "$(CYAN)make pienter-launcher$(RESET) - Run pienter-launcher"
	@echo "$(CYAN)make pienter-linker$(RESET)   - Run pienter-linker"
.PHONY: help

karabiner-build:
	$(call log_info,"Building Karabiner configura wction...")
	@cd ./karabiner/karabiner-config/ && yarn build
	$(call log_success,"Karabiner configuration built successfully")
.PHONY: karabiner-build

profile-zshrc:
	$(call log_info,"Profiling zsh configuration...")
	@time ZPROF=1 zsh -i -c exit
	$(call log_success,"Profiling complete")
.PHONY: profile-zshrc

brew:
	$(call log_info,"Checking Homebrew installation...")
	@./brew/brew-install.sh || ($(call log_error,"Failed to install Homebrew") && exit 1)
	$(call log_info,"Updating Homebrew...")
	@brew update || ($(call log_error,"Failed to update Homebrew") && exit 1)
	$(call log_info,"Upgrading packages...")
	@brew upgrade || ($(call log_error,"Failed to upgrade packages") && exit 1)
	$(call log_success,"Homebrew setup complete")
.PHONY: brew

brew-install: brew
	$(call log_info,"Installing Homebrew packages...")
	@cd ./brew/ && brew bundle || ($(call log_error,"Failed to install packages") && exit 1)
	$(call log_success,"Brew bundle installation complete")
.PHONY: brew-install

brew-doctor:
	$(call log_info,"Running brew doctor...")
	@brew doctor || ($(call log_warning,"Issues found by brew doctor"))
	$(call log_success,"Brew doctor check complete")
.PHONY: brew-doctor

brew-cleanup:
	$(call log_info,"Cleaning up Homebrew...")
	@cd ./brew && brew bundle cleanup --force || ($(call log_error,"Failed to clean up Homebrew") && exit 1)
	$(call log_success,"Homebrew cleanup complete")
.PHONY: brew-cleanup

pienter-launcher:
	cd $(ROOT) &&  pienter-launcher
.PHONY: pienter-launcher

pienter-binner:
	pienter-binner
.PHONY: pienter-binner

pienter-linker:
	pienter-linker
.PHONY: pienter-linker
