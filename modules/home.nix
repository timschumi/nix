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

    programs.bash.enable = true;
    programs.bash.enableCompletion = true;

    programs.vim.enable = true;
    programs.vim.defaultEditor = true;

    programs.home-manager.enable = true;
  };
}
