{
  inputs,
  pkgs,
  ...
}:
{
  home-manager.users.tim = {
    programs.thunderbird = {
      enable = true;
      profiles = {
        main = {
          isDefault = true;
        };
      };
    };
  };
}
