{ inputs, ... }:
{
  system = "aarch64-linux";
  modules = [
    (inputs.self + "/fragments/comma.nix")
    (inputs.self + "/fragments/variant-desktop.nix")

    (
      { ... }:
      {
        config = {
          extra = {
            user = {
              tim = {
                roles = [
                ];
              };
            };
          };
        };
      }
    )

    (
      {
        config,
        lib,
        pkgs,
        modulesPath,
        ...
      }:
      {
        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
        ];

        boot.initrd.availableKernelModules = [ "xhci_pci" ];
        boot.initrd.kernelModules = [
          "vc4"
          "bcm2835_dma"
          "i2c_bcm2835"
        ];
        boot.kernelModules = [ ];
        boot.extraModulePackages = [ ];

        fileSystems."/".device = lib.mkForce "/dev/disk/by-uuid/fd106a6e-ef20-4805-994e-2c2c5d0059da";

        swapDevices = [ ];

        nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

        boot.loader.grub.enable = false;
        boot.loader.generic-extlinux-compatible.enable = true;

        networking.hostName = "rpi3bp";
      }
    )
  ];
}
