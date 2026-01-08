{ extraSettings ? { } }:
let
  defaultSettings = {
    # theme = "GitHub-Dark-Dimmed";
    # font-family = "ZedMono Nerd Font";
    # font-size = "14";
    cursor-style = "bar";
    window-padding-x = "10,10";
    window-padding-y = "10,10";
    resize-overlay = "never";
    confirm-close-surface = false;
    # background-opacity = 0.85;
    gtk-single-instance = true;
  };
in {
  enable = true;
  settings = defaultSettings // extraSettings;
}
