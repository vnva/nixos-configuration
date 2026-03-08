{ pkgs, ... }:

{
  # https://nixos.wiki/wiki/Node.js#Install_to_your_home
  home.sessionPath = [ "$HOME/.npm-global/bin" ];

  home.packages = [ pkgs.nodejs_24 ];
}
