{
  config,
  inputs,
  pkgs,
  ...
}: {
  # Relevant settings borrowed from /nixos/modules/installer/cd-dvd/installation-cd-base.nix
  # Build using #nixosConfigurations.<hostname>.config.system.build.isoImage

  imports = [
    (inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/iso-image.nix")
  ];

  isoImage.isoName = "${config.isoImage.isoBaseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.iso";

  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;

  swapDevices = inputs.nixpkgs.lib.mkImageMediaOverride [];
  fileSystems = inputs.nixpkgs.lib.mkImageMediaOverride config.lib.isoFileSystems;
}
