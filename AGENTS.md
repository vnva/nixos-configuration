# AGENTS.md - NixOS Configuration Repository

## Build & Test Commands

```bash
# Rebuild system with justfile
just rebuild HOST_NAME TARGET_HOST
# Example: just rebuild laptop root@192.168.1.100

# Deploy with nixos-anywhere
just deploy HOST_NAME TARGET_HOST
# Example: just deploy vm root@example.com

# Launch quickshell
just quickshell
```

## Architecture & Structure

### Core Files
- **flake.nix**: Main entry point; defines inputs (nixpkgs, nixpkgs-unstable, disko, sops-nix, home-manager, stylix, quickshell, llm-agents) and outputs (nixosConfigurations for vm, laptop)
- **flake.lock**: Locked dependency versions
- **justfile**: Common commands for rebuild, deploy, and quickshell

### Modules
- **modules/mk-system.nix**: Helper function creating NixOS system configurations; manages overlays (unstable, quickshell, claude-code, amp) and integrates disko, sops-nix, stylix, home-manager
- **modules/users/**: User definitions (root, vnva) with sudo management
- **modules/common-system-packages.nix**: System-wide packages
- **modules/common-user-packages.nix**: User packages
- **modules/shell/default.nix**: Zsh configuration with starship, fzf, carapace
- **modules/git/default.nix**: Git configuration
- **modules/node/default.nix**: Node.js configuration
- **modules/vscode/default.nix**: VS Code configuration
- **modules/ghostty/default.nix**: Ghostty terminal configuration

### Host Configurations
- **hosts/vm/**: VM configuration (default.nix, disk.nix, hardware.nix)
  - GRUB bootloader with EFI support
  - SSH enabled on port 22
- **hosts/laptop/**: Laptop configuration (default.nix, disk.nix, hardware.nix)
  - Systemd-boot bootloader
  - NetworkManager
  - Timezone: Asia/Krasnoyarsk
  - SSH enabled on port 22
  - TLP battery management (charge 60-75%)

### Home Manager
- **home/ox/**: User home configuration (ox)
  - **default.nix**: Main home config, state version 25.05, imports stylix, hyprland, shell, node
  - **stylix.nix**: Color scheme and font management
  - **hyprland.nix**: Hyprland window manager with dwindle layout, keybindings (Super+Q for terminal, Super+R for rofi)
  - **extra.nix**: Extra configurations (if present)
  - **quickshell/**: Custom quickshell configuration

### Configuration & Secrets
- **vars/default.nix**: Personal variables (fullName, userName: vnva, userEmail, github config, SSH key)
- **secrets/default.yaml**: Encrypted secrets (sops-nix)
- **.sops.yaml**: SOPS configuration with age keys for desktop, laptop, vm

## Key Dependencies

| Dependency | Purpose |
|---|---|
| nixpkgs (25.05) | Core NixOS packages |
| nixpkgs-unstable | Latest packages via overlays |
| disko | Disk partitioning and formatting |
| sops-nix | Secrets management with age encryption |
| home-manager (25.11) | User home environment management |
| stylix (25.05) | Unified color scheme and fonts |
| quickshell | Custom shell/dashboard application |
| llm-agents | LLM tools (claude-code, amp) |

## Code Style & Guidelines

### Language & Formatting
- **Language**: Nix (declarative configuration)
- **Indentation**: 2 spaces
- **Line Length**: No hard limits
- **Imports**: Use `inherit` for attribute set destructuring; relative paths for local imports
- **Functions**: Curried functions (take inputs, return functions) for modularity

### Comments & Documentation
- Multi-line comments for module documentation
- Explain `why`, not `what`
- TODO comments for future improvements

### Naming Conventions
- Lowercase with hyphens (nix-command, efiSupport)
- Host names: lowercase (vm, laptop)
- User names: lowercase (vnva, ox for home-manager)
- Module names: descriptive with hyphens

### Secrets & Security
- Never hardcode secrets in flake.nix
- Use sops-nix with age encryption for all secrets
- Age keys stored in .sops.yaml
- Secrets file: secrets/default.yaml (encrypted)

### State & Versions
- Lock `system.stateVersion = "25.05"` to prevent breaking changes
- Lock `home.stateVersion = "25.05"` for home-manager
- Disable mutable users: `users.mutableUsers = false`

## Project Metadata

- **Repository**: https://github.com/vnva/nixos-configuration
- **Author**: Vyacheslav Ananev (vnva)
- **Hosts**: vm, laptop (both x86_64-linux)
- **Home Manager User**: ox (maps to system user: vnva)
- **Desktop Environment**: Hyprland (wayland)
- **Shell**: Zsh with Starship prompt
- **Terminal**: Ghostty
