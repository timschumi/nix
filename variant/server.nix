{...}: {
  imports = [
    ./base.nix
  ];

  networking.firewall.enable = true;
  networking.wireless.enable = true;
}
