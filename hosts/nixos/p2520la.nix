{ inputs, ... }:
{
  system = "x86_64-linux";
  modules = [
    (inputs.self + "/fragments/comma.nix")
    (inputs.self + "/fragments/discord.nix")
    (inputs.self + "/fragments/firefox.nix")
    (inputs.self + "/fragments/plasma.nix")
    (inputs.self + "/fragments/pipewire.nix")
    (inputs.self + "/fragments/spotify.nix")
    (inputs.self + "/fragments/variant-desktop.nix")

    (
      { ... }:
      {
        config = {
          extra = {
            user = {
              tim = {
                enable = true;
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

        boot.initrd.availableKernelModules = [
          "xhci_pci"
          "ehci_pci"
          "ahci"
          "usb_storage"
          "sd_mod"
          "sr_mod"
        ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" ];
        boot.extraModulePackages = [ ];

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/d947f459-04f0-46fb-9476-dc3876eb36ee";
          fsType = "ext4";
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/8814-D120";
          fsType = "vfat";
        };

        swapDevices = [ ];

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.intel.updateMicrocode = true;

        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        networking.hostName = "p2520la";
        age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILlVgir2hj+ZfISiwmmSs7JMGgLF0UHxWKHvr0h8wP/I";
      }
    )
  ];
}
