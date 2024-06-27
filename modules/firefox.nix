{
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.tim = {
    programs.firefox.enable = true;
    programs.firefox.profiles.main.isDefault = true;
  };
}
