{
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.tim = {
    home.packages = with pkgs; [
      gpu-screen-recorder
    ];
  };
}
