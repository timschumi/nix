{...}: {
  imports = [
    ./base.nix
  ];

  networking.firewall.enable = true;
  networking.wireless.enable = true;

  services.openssh = {
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  virtualisation.docker.enable = true;
  users.users.tim.extraGroups = ["docker"];
}
