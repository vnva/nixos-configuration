# AGENTS.md - NixOS Configuration Repository

## Build & Test Commands

```bash
# Check flake syntax and dependencies
nix flake check

# Lock flake dependencies
nix flake lock

# Build VM configuration
nix build .#nixosConfigurations.vm.config.system.build.vm

# Test VM (requires hardware.nix)
nix run .#nixosConfigurations.vm.config.system.build.vm -- -m 2048

# Generate hardware config on target
nix run github:nix-community/nixos-anywhere -- \
  --generate-hardware-config nixos-generate-config ./hardware-configuration.nix \
  root@<ip> <path>#<host>
```

## Architecture & Structure

- **flake.nix**: Main entry point; defines inputs (nixpkgs, disko) and outputs (nixosConfigurations)
- **modules/mk-system.nix**: Helper function that creates NixOS system configurations
- **modules/users/**: User definitions (root, vnva) with sudo management
- **hosts/vm/**: VM-specific configuration (default.nix, disk.nix, hardware.nix)
- **scripts/**: Deployment scripts (deploy.sh)
- **docs/**: Documentation (nix-anywhere.md)

Key dependencies: nixpkgs (unstable), disko (disk partitioning)

## Code Style & Guidelines

- **Language**: Nix (declarative configuration)
- **Formatting**: 2-space indentation, no hard line limits
- **Imports**: Use `inherit` for attribute set destructuring; relative paths for local imports
- **Functions**: Curried functions (take inputs, return functions) for modularity
- **Comments**: Multi-line comments for module documentation; explain `why`, not `what`
- **Naming**: Use lowercase with hyphens (nix-command, efiSupport)
- **Secrets**: Never hardcode in flake.nix; use agenix or sops-nix for production
- **State Version**: Lock `system.stateVersion` to prevent breaking changes
