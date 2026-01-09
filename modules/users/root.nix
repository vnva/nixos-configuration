{ pkgs, config, ... }:

let vars = import ../../vars/default.nix;

in {
  sops.secrets.personalHashedPassword.neededForUsers = true;

  programs.zsh.enable = true;

  users.users.root = {
    hashedPasswordFile = config.sops.secrets.personalHashedPassword.path;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ vars.personal.ssh.publicKey ];
  };
}
