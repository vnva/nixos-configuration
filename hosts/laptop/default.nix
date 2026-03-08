{ config, lib, pkgs, ... }:

{
  imports = [ ./disk.nix ./hardware.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = { networkmanager.enable = true; };

  time.timeZone = "Asia/Krasnoyarsk";

  services.openssh = {
    enable = true;
    ports = [ 22 ];
  };

  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 60;
      STOP_CHARGE_THRESH_BAT0 = 75;
    };
  };

  services.fwupd.enable = true;
  services.fstrim.enable = true;

  systemd.services.platform-profile = {
    description = "Set ACPI platform profile to performance";
    wantedBy = [ "multi-user.target" ];
    after = [ "sysinit.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${
          lib.getExe pkgs.bash
        } -c 'if [ -w /sys/firmware/acpi/platform_profile ]; then echo performance > /sys/firmware/acpi/platform_profile; fi'";
    };
  };
}
