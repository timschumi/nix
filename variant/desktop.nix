{...}: {
  imports = [
    ./base.nix
  ];

  networking.networkmanager.enable = true;
}
