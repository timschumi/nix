{
  role,
  user,
  ...
} @ presets: {
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (builtins) elem;
  inherit (inputs.nixpkgs.lib) mkIf;
in {
  config = mkIf (elem role config.extra.user."${user}".roles) {
    programs.adb.enable = true;
    users.users."${user}".extraGroups = ["adbusers"];

    home-manager.users."${user}" = {
      home.packages = with pkgs; [
        brotli
        bsdiff
        (heimdall-gui.overrideAttrs (final: prev: rec {
          version = "2.0.2";
          src = pkgs.fetchFromSourcehut {
            owner = "~grimler";
            repo = "Heimdall";
            rev = "v${version}";
            sha256 = "sha256-tcAE83CEHXCvHSn/S9pWu6pUiqGmukMifEadqPDTkQ0=";
          };
        }))
        scrcpy
        sdat2img
      ];
    };
  };
}
