{
  inputs,
  pkgs,
  ...
}:
{
  home-manager.users.tim = {
    home.packages = with pkgs; [
      vesktop
    ];
  };
}
