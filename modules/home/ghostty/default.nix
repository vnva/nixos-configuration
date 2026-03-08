{ extraSettings ? { } }:
let
  defaultSettings = {
    cursor-style = "bar";
    window-padding-x = "10,10";
    window-padding-y = "10,10";
    resize-overlay = "never";
    confirm-close-surface = false;
    gtk-single-instance = true;
  };
in {
  enable = true;
  settings = defaultSettings // extraSettings;
}
