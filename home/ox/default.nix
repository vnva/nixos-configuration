{ pkgs, config, ... }:

{
  home.stateVersion = "25.05";

  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  imports = [
    ./stylix.nix
    ./hyprland.nix
    (import ../../modules/shell { inherit pkgs; })
  ];

  home.packages = [ pkgs.dconf pkgs.rofi-wayland ]
    ++ (import ../../modules/common-user-packages.nix { inherit pkgs; });

  dconf.enable = true;

  programs.quickshell = import ./quickshell { inherit pkgs config; };

  programs.git = import ../../modules/git { };

  programs.vscode = import ../../modules/vscode {
    inherit pkgs;
    extraSettings = {
      # ui
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "Framer Syntax";

      # fonts
      "editor.fontLigatures" = true;
      "terminal.integrated.fontLigatures" = true;
      "editor.fontFamily" = "${config.stylix.fonts.monospace.name}";
      "terminal.integrated.fontFamily" =
        "'${config.stylix.fonts.monospace.name}'";
    };
  };

  programs.ghostty = import ../../modules/ghostty {
    extraSettings = { background-opacity = 0.85; };
  };
}
