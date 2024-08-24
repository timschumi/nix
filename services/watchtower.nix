{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  virtualisation.oci-containers.containers."watchtower" = {
    image = "docker.io/containrrr/watchtower:latest";
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock:rw"
    ];
    log-driver = "journald";
    cmd = [
      "--cleanup"
      "--interval"
      "300"
    ];
  };
}
// import (inputs.self + "/lib/container-fail-restart.nix") {
  inherit config;
  inherit lib;
  unit = "watchtower";
  limit = 10;
}
