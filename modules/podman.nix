{
  pkgs,
  lib,
  ...
}: {
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      dns_enabled = true;
    };
  };
  virtualisation.oci-containers.backend = "podman";

  # The setting linked to dns_enabled is not enough for non-default networks.
  networking.firewall.interfaces."podman+".allowedUDPPorts = [53 5353];
  networking.firewall.interfaces."podman+".allowedTCPPorts = [53];

  # Provide a compose implementation for `podman compose`.
  environment.systemPackages = with pkgs; [
    podman-compose
  ];
}
