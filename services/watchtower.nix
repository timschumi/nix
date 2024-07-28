{
  config,
  pkgs,
  lib,
  ...
}: {
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
  systemd.services."${config.virtualisation.oci-containers.backend}-watchtower" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "on-failure";
    };
    startLimitBurst = 10;
    unitConfig = {
      StartLimitIntervalSec = lib.mkOverride 500 "infinity";
    };
  };
}
