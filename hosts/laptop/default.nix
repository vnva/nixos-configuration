{
  imports = [
    ./disk.nix
    ./hardware.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    networkmanager.enable = true;
  };

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
}