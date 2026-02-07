rebuild HOST_NAME TARGET_HOST:
  nixos-rebuild switch --flake .#{{HOST_NAME}} --target-host {{TARGET_HOST}}

deploy HOST_NAME TARGET_HOST:
  nix run github:nix-community/nixos-anywhere -- --flake ".#{{HOST_NAME}}" {{TARGET_HOST}}

self HOST_NAME:
  sudo nixos-rebuild switch --flake .#{{HOST_NAME}}
  

quickshell:
  quickshell -p ./home/ox/quickshell/default
