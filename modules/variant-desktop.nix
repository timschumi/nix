{...}: {
  imports = [
    ./variant-base.nix
  ];

  networking.firewall.enable = false;
  networking.networkmanager.enable = true;
}
