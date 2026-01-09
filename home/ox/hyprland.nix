{ config, pkgs, lib, osConfig, ... }:

let
  wallpaper = "${../../assets/wallpapers/warm-texture.jpg}";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
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
      monitor = lib.mkIf (osConfig.networking.hostName == "laptop") [
        "eDP-1,preferred,auto,1.8"
      ];
      general = {
        "gaps_in" = 5;
        "gaps_out" = "5 10 10 10";
        "border_size" = 0;
        "resize_on_border" = false;
        "layout" = "dwindle";
      };
      decoration = {
        "rounding" = 5;
        shadow = {
          enabled = false;
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          new_optimizations = true;
          noise = 0.2;
        };
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
      bind = [
        # apps
        "$mod, Q, exec, $terminal"

        # window
        "$mod, C, killactive"
        "$mod, F, fullscreen"
        "$mod, V, togglefloating"

        # system
        "$mod SHIFT, M, exit"

        # special workspace
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
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
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
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
