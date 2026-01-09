{ osConfig, pkgs, ... }:

{
  # for vscode
  fonts.packages =
    [ pkgs.inter pkgs.nerd-fonts.zed-mono pkgs.noto-fonts-color-emoji ];
}
