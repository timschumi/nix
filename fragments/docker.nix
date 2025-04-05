{
  lib,
  pkgs,
  ...
}:
{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  virtualisation.oci-containers.backend = "docker";
}
