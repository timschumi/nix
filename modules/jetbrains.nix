{
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.tim = {
    home.packages = with pkgs.jetbrains; [
      clion
      pkgs.clang
      pkgs.pkg-config
      idea-ultimate
      phpstorm
      pycharm-professional
      rider
      rust-rover
      pkgs.rustup
    ];
  };
}
