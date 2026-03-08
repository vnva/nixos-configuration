{ osConfig, pkgs, lib, ... }:

{
  services.upower.enable = true;

  # ========= HYPRLAND GTK FIXES ========
  # https://github.com/matthewpi/nixos-config/blob/0965250feda8fa3d386cda3605cf6974b1320eb6/modules/hyprland/default.nix#L84

  # Enable gvfs
  services.gvfs.enable = lib.mkDefault true;

  # Enable glib-networking.
  services.gnome.glib-networking.enable = lib.mkDefault true;

  # Fixes issues with XDG portal definitions not being detected.
  # ref; https://nix-community.github.io/home-manager/options.xhtml#opt-xdg.portal.enable
  environment.pathsToLink =
    [ "/share/applications" "/share/xdg-desktop-portal" ];

  services.graphical-desktop.enable = lib.mkDefault false;

  # ========= END HYPRLAND GTK FIXES ========

  # for vscode
  fonts.packages =
    [ pkgs.inter pkgs.nerd-fonts.zed-mono pkgs.noto-fonts-color-emoji ];
}
