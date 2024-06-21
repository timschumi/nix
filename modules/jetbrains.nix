{
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.tim = {
    home.packages = with pkgs.jetbrains; [
      clion
      idea-ultimate
      phpstorm
      pycharm-professional
      rider
      rust-rover
    ];
  };
}
