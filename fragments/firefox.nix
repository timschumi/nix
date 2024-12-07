{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nur.modules.nixos.default
  ];

  home-manager.users.tim = {
    programs.firefox = {
      enable = true;
      profiles = {
        main = {
          isDefault = true;
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            keepassxc-browser
            reddit-enhancement-suite
            sponsorblock
            ublock-origin
          ];
        };
      };
    };
  };
}
