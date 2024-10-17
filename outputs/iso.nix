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

  # The live boot ISO did not have the option to set a root password,
  # allow authenticating via pubkeys here.
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFWSvBiQLNvqFY4iCzJ7scnstK872QOS5VtzuyXlXNzV"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMVEVylmxWUFCRuBOCz0wTjwfjot649TDoH9hQIWflXZ"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHInF0SYfQJGDv0w09UgbZv+cr1Ot2CsBn2kjFXflIY1"
  ];
}
