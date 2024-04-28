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

    programs.git.enable = true;
    programs.git.lfs.enable = true;
    programs.git.userName = "Tim Schumacher";
    programs.git.userEmail = "timschumi@gmx.de";
    programs.git.aliases.c = "commit --verbose";
    programs.git.aliases.ca = "c --amend";
    programs.git.aliases.cad = "ca --date=now";
    programs.git.aliases.graph = "log --oneline --graph";

    programs.home-manager.enable = true;
  };
}
