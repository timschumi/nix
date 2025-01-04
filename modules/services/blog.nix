{
  config,
  inputs,
  ...
}: let
  inherit (inputs.nixpkgs.lib) mkIf;
  inherit (inputs.nixpkgs.lib.options) mkEnableOption mkOption;
  inherit (inputs.nixpkgs.lib.types) str;
in {
  options.extra.services.blog = {
    enable = mkEnableOption "Enable the `blog` service";
    domain = mkOption {
      type = str;
    };
  };

  config = mkIf config.extra.services.blog.enable {
    virtualisation.oci-containers.containers."blog" = {
      image = "ghcr.io/timschumi/blog:latest";
      login = {
        username = "timschumi";
        registry = "ghcr.io";
        passwordFile = "/secrets/ghcr-token";
      };
      environment = {
        TZ = "Europe/Berlin";
      };
      labels = {
        "traefik.enable" = "true";
        "traefik.http.routers.blog.entrypoints" = "public-https";
        "traefik.http.routers.blog.rule" = "Host(`${config.extra.services.blog.domain}`)";
      };
      log-driver = "journald";
    };
  };
}
