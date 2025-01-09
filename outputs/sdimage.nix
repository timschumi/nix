{
  config,
  inputs,
  pkgs,
  ...
}:
let
  inherit (inputs.nixpkgs.lib.asserts) assertMsg;
  inherit (inputs.nixpkgs.lib.strings) hasPrefix removePrefix;
  rootfs = config.fileSystems."/";
  uuidPrefix = "/dev/disk/by-uuid/";
  isUuidPartition = hasPrefix uuidPrefix;
in
{
  imports = [
    (inputs.nixpkgs + "/nixos/modules/installer/sd-card/sd-image-aarch64.nix")
  ];

  sdImage.rootPartitionUUID =
    assert assertMsg (isUuidPartition rootfs.device)
      "Root partition needs to be identified using UUID, '${rootfs.device}' is not.";
    removePrefix uuidPrefix rootfs.device;

  # Save some time, we will mostly be using these locally.
  sdImage.compressImage = false;

  # Live media does not have any passwords set, so we can't sudo or log into root by default.
  users.users.root.openssh.authorizedKeys.keys = config.extra.adminKeys;
}
