{inputs, ...}: {
  system = "aarch64-linux";
  modules = [
    (inputs.self + "/fragments/variant-desktop.nix")
    (inputs.self + "/fragments/comma.nix")
    (inputs.self + "/fragments/home.nix")

    (inputs.nixpkgs + "/nixos/modules/installer/sd-card/sd-image-aarch64.nix")

    (
      {
        config,
        lib,
        pkgs,
        modulesPath,
        ...
      }: {
        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
        ];

        boot.initrd.availableKernelModules = ["xhci_pci"];
        boot.initrd.kernelModules = ["vc4" "bcm2835_dma" "i2c_bcm2835"];
        boot.kernelModules = [];
        boot.extraModulePackages = [];

        sdImage.rootPartitionUUID = "2598aea4-bfe9-433e-82fa-7bae4ba6ac45";
        fileSystems."/".device = lib.mkForce "/dev/disk/by-uuid/${config.sdImage.rootPartitionUUID}";

        sdImage.compressImage = false;

        swapDevices = [];

        nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

        boot.loader.grub.enable = false;
        boot.loader.generic-extlinux-compatible.enable = true;

        networking.hostName = "rpi02w";
      }
    )
  ];
}
