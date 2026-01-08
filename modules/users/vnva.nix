{ pkgs, config, ... }:

let
  vars = import ../../vars/default.nix;
in

{
  sops.secrets.personalHashedPassword.neededForUsers = true;

  programs.zsh.enable = true;

  users.users.vnva = {
    description = "Vyacheslav Ananev";
    hashedPasswordFile = config.sops.secrets.personalHashedPassword.path;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    home = "/home/vnva";
    isNormalUser = true;
    createHome = true;
    openssh.authorizedKeys.keys = [
      vars.personal.ssh.publicKey
    ];
  };

  security.sudo.wheelNeedsPassword = false;
}
