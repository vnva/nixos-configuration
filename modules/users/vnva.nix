{ pkgs, config, ... }:

let vars = import ../../vars/default.nix;
in {
  sops.secrets.personalHashedPassword.neededForUsers = true;

  programs.zsh.enable = true;
  programs.zsh.enableGlobalCompInit = false;

  users.users.vnva = {
    description = vars.personal.fullName;
    hashedPasswordFile = config.sops.secrets.personalHashedPassword.path;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    home = "/home/vnva";
    isNormalUser = true;
    createHome = true;
    openssh.authorizedKeys.keys = [ vars.personal.ssh.publicKey ];
    ignoreShellProgramCheck = true;
  };

  security.sudo.wheelNeedsPassword = false;
}
