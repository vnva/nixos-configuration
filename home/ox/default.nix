{ ... }:

{
  home.stateVersion = "25.05";
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.ghostty = import ../../modules/ghostty {};

  imports = [
    ./hyprland.nix
  ];
}