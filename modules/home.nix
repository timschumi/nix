{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.users.tim = {
    home.username = "tim";
    home.homeDirectory = "/home/tim";
    home.stateVersion = "23.11";

    programs.home-manager.enable = true;
  };
}
