{
  config,
  lib,
  unit,
  limit,
  ...
}: {
  systemd.services."${config.virtualisation.oci-containers.backend}-${unit}" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "on-failure";
    };
    startLimitBurst = limit;
    unitConfig = {
      StartLimitIntervalSec = lib.mkOverride 500 "infinity";
    };
  };
}
