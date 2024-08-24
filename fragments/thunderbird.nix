{
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.tim = {
    programs.thunderbird.enable = true;
    programs.thunderbird.profiles.main.isDefault = true;
  };
}
