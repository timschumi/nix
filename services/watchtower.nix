{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  virtualisation.oci-containers.containers."watchtower" = {
    image = "docker.io/containrrr/watchtower:latest";
    volumes = [
      "/var/run/podman/podman.sock:/var/run/docker.sock:rw"
    ];
    log-driver = "journald";
    cmd = [
      "--cleanup"
      "--interval" "300"
    ];
  };
}
// (inputs.self + "/lib/container-fail-restart.nix") {
  inherit config;
  unit = "watchtower";
  limit = 10;
}
