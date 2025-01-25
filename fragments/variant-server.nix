{ ... }:
{
  imports = [
    ./variant-base.nix
  ];

  networking = {
    firewall.enable = true;
  };

  services.openssh = {
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
