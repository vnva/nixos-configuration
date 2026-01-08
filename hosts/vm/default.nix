{
  imports = [
    ./disk.nix
    ./hardware.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
  };
}