{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nur.nixosModules.nur
  ];

  home-manager.users.tim = {
    programs.firefox = {
      enable = true;
      profiles = {
        main = {
          isDefault = true;
          extensions = with config.nur.repos.rycee.firefox-addons; [
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
