{...}: {
  imports = [
    ./variant-base.nix
  ];

  networking = {
    firewall.enable = false;
    networkmanager.enable = true;
  };
}
