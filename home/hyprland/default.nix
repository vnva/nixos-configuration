{ pkgs, config, ... }:

{
  home.stateVersion = "25.05";

  home.sessionVariables.EDITOR = "nvim";

  imports = [
    ../../modules/home/node
    ./hyprland.nix
    ./stylix.nix
    (import ../../modules/home/shell { inherit pkgs; })
  ];

  home.packages = [
    pkgs.dconf

    # TODO: replace with quickshell
    pkgs.rofi 
  ] ++ (import ../../modules/common-user-packages.nix { inherit pkgs; });

  dconf.enable = true;

  programs.git = import ../../modules/home/git { };

  programs.vscode = import ../../modules/home/vscode {
    inherit pkgs;
    extraSettings = {
      # ui
      "window.titleBarStyle" = "native";
      "workbench.colorTheme" = "Framer Syntax";

      # fonts
      "editor.fontLigatures" = true;
      "terminal.integrated.fontLigatures" = true;
      "editor.fontFamily" = "${config.stylix.fonts.monospace.name}";
      "terminal.integrated.fontFamily" = "'${config.stylix.fonts.monospace.name}'";
    };
  };

  programs.ghostty = import ../../modules/home/ghostty {
    extraSettings = { background-opacity = 0.85; };
  };
}
