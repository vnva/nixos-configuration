{ pkgs, config, ... }:

{
  imports = [
    ./stylix.nix
    ./hyprland.nix
  ];

  home.stateVersion = "25.05";
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = [
    pkgs.dconf
    pkgs.rofi-wayland
  ] ++ (import ../../modules/common-user-packages.nix { inherit pkgs; });

  dconf.enable = true;

  programs.quickshell = import ./quickshell { inherit pkgs config; };

  programs.vscode = import ../../modules/vscode { inherit pkgs; };
  programs.ghostty = import ../../modules/ghostty {
    extraSettings = {
      background-opacity = 0.85;
    };
  };
}