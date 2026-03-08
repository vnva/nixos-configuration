{ pkgs }:

[
  # development
  pkgs.git
  pkgs.neovim
  pkgs.nixfmt-classic

  # network
  pkgs.curl
  pkgs.mtr
  pkgs.nmap
  pkgs.wget
  pkgs.whois

  # utils
  pkgs.jq
  pkgs.just
  pkgs.sops
  pkgs.tree
  pkgs.unzip
]
