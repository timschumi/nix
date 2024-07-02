{
  pkgs,
  inputs,
  ...
}: {
  programs.adb.enable = true;
  users.users.tim.extraGroups = ["adbusers"];

  home-manager.users.tim = {
    home.packages = with pkgs; [
      (heimdall-gui.overrideAttrs (final: prev: rec {
        version = "2.0.2";
        src = pkgs.fetchFromSourcehut {
          owner = "~grimler";
          repo = "Heimdall";
          rev = "v${version}";
          sha256 = "sha256-tcAE83CEHXCvHSn/S9pWu6pUiqGmukMifEadqPDTkQ0=";
        };
      }))
    ];
  };
}
