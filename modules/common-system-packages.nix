{ pkgs }:

[
  # network
  pkgs.curl
  pkgs.wget
  pkgs.mtr
  pkgs.nmap
  pkgs.whois

  # utils
  pkgs.jq
  pkgs.just
  pkgs.sops
  pkgs.unzip
  pkgs.tree

  # development
  pkgs.git
  pkgs.nixfmt-classic
  pkgs.neovim
]
