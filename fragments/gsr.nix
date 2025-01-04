{
  inputs,
  pkgs,
  ...
}:
{
  programs.gpu-screen-recorder.enable = true;
  home-manager.users.tim = with pkgs; {
    home.packages = [
      gpu-screen-recorder
      gpu-screen-recorder-gtk
      killall
    ];
  };
}
