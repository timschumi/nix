{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./d800-hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "d800";
  networking.wireless.enable = true;

  time.timeZone = "Europe/Berlin";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de-latin1-nodeadkeys";
  };

  users.users.tim = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      curl
      tree
      vim
      wget
    ];
  };

  services.openssh.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "23.11";

}


