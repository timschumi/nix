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
    programs.firefox.enable = true;
    programs.firefox.profiles.main.isDefault = true;
    programs.firefox.profiles.main.extensions = with config.nur.repos.rycee.firefox-addons; [
      keepassxc-browser
      reddit-enhancement-suite
      sponsorblock
      ublock-origin
    ];
  };
}
