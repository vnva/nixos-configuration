{ config, pkgs, ... }:

let
  wallpaper = "${../../assets/wallpapers/warm-texture.jpg}";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "ghostty";
      input = {
        "kb_layout" = "us,ru";
        "kb_options" = "grp:alt_shift_toggle";
        "repeat_delay" = 200;
        "repeat_rate" = 50;
      };
      animations = { enabled = false; };
      bind = [
        # apps
        "$mod, Q, exec, $terminal"

        # window
        "$mod, C, killactive"
        "$mod, F, fullscreen"
        "$mod, V, togglefloating"

        # system
        "$mod SHIFT, M, exit"
      ]
      ++ (builtins.concatLists (builtins.genList (x:
        let workspace = toString (x + 1);
        in [
          # Switch to workspace
          "$mod, ${workspace}, workspace, ${workspace}"
          # Move active window to workspace
          "$mod SHIFT, ${workspace}, movetoworkspace, ${workspace}"
        ]
      ) 9));
      general = {
        "gaps_in" = 5;
        "gaps_out" = 10;
        "border_size" = 0;
        "resize_on_border" = false;
        "layout" = "dwindle";
      };
      decoration = {
        "rounding" = 8;
      };
      misc = {
        "disable_hyprland_logo" = true;
      };
      dwindle = {
        "pseudotile" = true;
        "preserve_split" = true;
        "default_split_ratio" = 1.05;
        "smart_split" = true;
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      ipc = "false";
      preload = [ wallpaper ];
      wallpaper = [ ",${wallpaper}" ];
    };
  };
}
