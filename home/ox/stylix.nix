{ pkgs, ... }:

{
  stylix = {
    enable = true;
    overlays.enable = false;
    # image = ../../assets/wallpapers/anime-dark.png;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/ia-dark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/isotope.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/irblack.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/framer.yaml";
    polarity = "dark";

    targets = { vscode.enable = false; };

    fonts = {
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = pkgs.nerd-fonts.zed-mono;
        name = "ZedMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = { desktop = 4; };
    };
  };
}
