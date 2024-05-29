{
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.tim = {
    programs.firefox.enable = true;
  };
}
