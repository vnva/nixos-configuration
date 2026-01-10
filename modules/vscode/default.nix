{ pkgs, extraSettings ? { } }:

let
  defaultSettings = {
    # window
    "workbench.sideBar.location" = "right";
    "window.menuBarVisibility" = "hidden";
    "editor.stickyScroll.enabled" = false;
    "workbench.tree.enableStickyScroll" = false;
    "terminal.integrated.stickyScroll.enabled" = false;
    "workbench.layoutControl.enabled" = false;
    "workbench.startupEditor" = "none";
    "update.mode" = "none";
    "window.commandCenter" = false;

    # disable default ai
    "chat.commandCenter.enabled" = false;
    "chat.agent.enabled" = false;
    "chat.disableAIFeatures" = true;

    # editor
    "editor.tabSize" = 2;

    "[nix]" = { "editor.formatOnSave" = true; };

    # updates
    "extensions.autoUpdate" = false;
  };
in {
  enable = true;

  package = pkgs.unstable.vscode;

  mutableExtensionsDir = true;

  profiles.default.userSettings = defaultSettings // extraSettings;

  profiles.default.extensions = [
    # Nix
    pkgs.unstable.vscode-extensions.jnoortheen.nix-ide

    # AI
    # pkgs.vscode-extensions.supermaven.supermaven

    # JS tooling
    pkgs.unstable.vscode-extensions.esbenp.prettier-vscode
    pkgs.unstable.vscode-extensions.dbaeumer.vscode-eslint
    pkgs.unstable.vscode-extensions.bradlc.vscode-tailwindcss
  ];
}
