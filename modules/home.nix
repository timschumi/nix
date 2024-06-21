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

    xdg.configFile."nixpkgs/config.nix".text = "{ allowUnfree = true; }";

    programs.bash.enable = true;
    programs.bash.enableCompletion = true;

    programs.neovim.enable = true;
    programs.neovim.defaultEditor = true;
    programs.neovim.vimAlias = true;

    programs.git.enable = true;
    programs.git.lfs.enable = true;
    programs.git.userName = "Tim Schumacher";
    programs.git.userEmail = "timschumi@gmx.de";
    programs.git.aliases.c = "commit --verbose";
    programs.git.aliases.ca = "c --amend";
    programs.git.aliases.cad = "ca --date=now";
    programs.git.aliases.graph = "log --oneline --graph";
    programs.git.aliases.cu = "!env GIT_COMMITTER_DATE=\\\"$(date --utc +%Y-%m-%dT%H:%M:%S%z)\\\" git commit --verbose --date=\\\"$(date --utc +%Y-%m-%dT%H:%M:%S%z)\\\"";
    programs.git.aliases.cau = "!env GIT_COMMITTER_DATE=\\\"$(date --utc +%Y-%m-%dT%H:%M:%S%z)\\\" git commit --verbose --date=\\\"$(date --utc +%Y-%m-%dT%H:%M:%S%z)\\\" --amend";

    programs.home-manager.enable = true;
  };
}
