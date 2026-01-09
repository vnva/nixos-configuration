{ pkgs, config }:

let
  colors = config.lib.stylix.colors;

  # Create a colors.js file with stylix colors
  colorsFile = pkgs.writeText "colors.js" ''
    .pragma library

    var transparentBase00 = "#D9${colors.base00}";
    var base00 = "#${colors.base00}";
    var base01 = "#${colors.base01}";
    var base02 = "#${colors.base02}";
    var base03 = "#${colors.base03}";
    var base04 = "#${colors.base04}";
    var base05 = "#${colors.base05}";
    var base06 = "#${colors.base06}";
    var base07 = "#${colors.base07}";
    var base08 = "#${colors.base08}";
    var base09 = "#${colors.base09}";
    var base0A = "#${colors.base0A}";
    var base0B = "#${colors.base0B}";
    var base0C = "#${colors.base0C}";
    var base0D = "#${colors.base0D}";
    var base0E = "#${colors.base0E}";
    var base0F = "#${colors.base0F}";
  '';

  # Create a config directory with the colors file
  configDir = pkgs.runCommand "quickshell-config" { } ''
    mkdir -p $out
    cp -r ${./default}/* $out/
    rm -rf $out/colors.js
    cp ${colorsFile} $out/colors.js
  '';
in {
  enable = true;
  package = pkgs.quickshell;
  systemd = {
    enable = true;
    target = "hyprland-session.target";
  };
  activeConfig = "default";
  configs = { default = configDir; };
}
