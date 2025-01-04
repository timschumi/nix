{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nix-index-database.nixosModules.nix-index
  ];

  # ???
  programs.command-not-found.enable = false;

  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.nix-index-database = {
    comma.enable = true;
  };
}
