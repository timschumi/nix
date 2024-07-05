{
  pkgs,
  inputs,
  ...
}: let
  gsr = pkgs.callPackage "${inputs.nixpkgs-gsr}/pkgs/applications/video/gpu-screen-recorder/default.nix" {};
  gsr-gtk = pkgs.callPackage "${inputs.nixpkgs-gsr}/pkgs/applications/video/gpu-screen-recorder/gpu-screen-recorder-gtk.nix" {
    gpu-screen-recorder = gsr;
  };
in {
  imports = [
    "${inputs.nixpkgs-gsr}/nixos/modules/programs/gpu-screen-recorder.nix"
  ];

  programs.gpu-screen-recorder.wrapCapabilities = true;
  programs.gpu-screen-recorder.package = gsr;
  home-manager.users.tim = {
    home.packages = [
      gsr
      gsr-gtk
      pkgs.killall
    ];
  };
}
