{
  pkgs,
  inputs,
  ...
}: let
  gsr = pkgs.callPackage "${inputs.nixpkgs-gsr}/pkgs/applications/video/gpu-screen-recorder/default.nix" {};
in {
  imports = [
    "${inputs.nixpkgs-gsr}/nixos/modules/programs/gpu-screen-recorder.nix"
  ];

  programs.gpu-screen-recorder.wrapCapabilities = true;
  programs.gpu-screen-recorder.package = gsr;
  home-manager.users.tim = {
    home.packages = [
      gsr
    ];
  };
}
