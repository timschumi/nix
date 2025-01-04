{
  role,
  user,
  ...
}@presets:
{
  config,
  inputs,
  pkgs,
  ...
}:
let
  inherit (builtins) elem filter;
  inherit (inputs.nixpkgs.lib) mkIf;
  inherit (inputs.nixpkgs.lib.strings) concatLines hasInfix splitString;
in
{
  config = mkIf (elem role config.extra.user."${user}".roles) {
    programs.adb.enable = true;
    users.users."${user}".extraGroups = [
      "adbusers"
      "dialout"
    ];

    home-manager.users."${user}" = {
      home.packages = with pkgs; [
        brotli
        bsdiff
        (heimdall-gui.overrideAttrs (
          final: prev: rec {
            version = "2.1.0";
            src = pkgs.fetchFromSourcehut {
              owner = "~grimler";
              repo = "Heimdall";
              rev = "v${version}";
              sha256 = "sha256-4tOUVwcUGAEpZR+2QntYSaphUQUjXUbJCpZIQoHuLog=";
            };
            installPhase = concatLines (
              filter (line: !(hasInfix "share/doc/heimdall/" line)) (splitString "\n" prev.installPhase)
            );
          }
        ))
        scrcpy
        sdat2img
      ];
    };
  };
}
