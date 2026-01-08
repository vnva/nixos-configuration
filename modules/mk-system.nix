# Creates a NixOS system configuration
# 
# Takes inputs (with nixpkgs) and returns a function that accepts:
#   - system: CPU architecture (default: "x86_64-linux")
#   - host: Host name for loading from hosts/${host}

{ inputs }:
{ system ? "x86_64-linux", home ? false, host }:

inputs.nixpkgs.lib.nixosSystem (
  let
    vars = import ../vars;

    overlays = [
      (final: prev: rec {
        quickshell = inputs.quickshell.packages.${system}.default;
      })
    ];
  in {
  inherit system;

  modules = [
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    inputs.stylix.nixosModules.stylix

    { nixpkgs.overlays = overlays; }

    {
      sops.defaultSopsFile = ../secrets/default.yaml;
      sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      sops.age.keyFile = "/var/lib/sops-nix/key.txt";
      sops.age.generateKey = true;
    }

    {
      system.stateVersion = "25.05";
      nixpkgs.config.allowUnfree = true;
      environment.enableAllTerminfo = true;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      users.mutableUsers = false;
      networking.hostName = host;
    }

    ({ pkgs, ... }: {
      environment.systemPackages = import ./common-system-packages.nix { inherit pkgs; };
    })

    ./users
    ../hosts/${host}
  ] ++ (inputs.nixpkgs.lib.optionals (builtins.isString home) [
    (if builtins.pathExists ../home/${home}/extra.nix then
      ../home/${home}/extra.nix
    else
      { })

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.users.${vars.personal.userName} = ../home/${home};
      # home-manager.extraSpecialArgs = { inherit vars; };

      home-manager.sharedModules = [ inputs.stylix.homeModules.stylix ];
    }
  ]);
})
