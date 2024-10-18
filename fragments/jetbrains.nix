{
  inputs,
  pkgs,
  ...
}: {
  home-manager.users.tim = {
    home.packages = with pkgs.jetbrains; [
      idea-ultimate
      phpstorm
      pycharm-professional
      rider
      rust-rover
      pkgs.rustup
    ];
  };
}
