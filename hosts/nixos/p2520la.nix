{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    (inputs.self + "/modules/variant-desktop.nix")
    (inputs.self + "/modules/comma.nix")
    (inputs.self + "/modules/home.nix")
    (inputs.self + "/modules/plasma.nix")
    (inputs.self + "/modules/pipewire.nix")

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

        boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod"];
        boot.initrd.kernelModules = [];
        boot.kernelModules = ["kvm-intel"];
        boot.extraModulePackages = [];

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/d947f459-04f0-46fb-9476-dc3876eb36ee";
          fsType = "ext4";
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/8814-D120";
          fsType = "vfat";
        };

        swapDevices = [];

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        networking.hostName = "p2520la";
      }
    )
  ];
}
