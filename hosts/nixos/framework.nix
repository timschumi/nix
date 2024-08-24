{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    (inputs.self + "/fragments/variant-desktop.nix")
    (inputs.self + "/fragments/adb.nix")
    (inputs.self + "/fragments/comma.nix")
    (inputs.self + "/fragments/discord.nix")
    (import (inputs.self + "/fragments/emulate.nix") [
      "aarch64-linux"
    ])
    (inputs.self + "/fragments/firefox.nix")
    (inputs.self + "/fragments/home.nix")
    (inputs.self + "/fragments/jetbrains.nix")
    (inputs.self + "/fragments/libvirt.nix")
    (inputs.self + "/fragments/lutris.nix")
    (inputs.self + "/fragments/opentabletdriver.nix")
    (inputs.self + "/fragments/plasma.nix")
    (inputs.self + "/fragments/pipewire.nix")
    (inputs.self + "/fragments/podman.nix")
    (inputs.self + "/fragments/spotify.nix")
    (inputs.self + "/fragments/steam.nix")
    (inputs.self + "/fragments/thunderbird.nix")

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

        boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
        boot.initrd.kernelModules = [];
        boot.kernelModules = ["kvm-intel"];
        boot.extraModulePackages = [];

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/432c262e-55e8-47b3-8c8a-f7febfaf6551";
          fsType = "ext4";
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/AB29-2241";
          fsType = "vfat";
          options = ["fmask=0077" "dmask=0077"];
        };

        swapDevices = [];

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.intel.updateMicrocode = true;

        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        networking.hostName = "framework";

        hardware.graphics = {
          enable = true;
          enable32Bit = true;
          extraPackages = with pkgs; [
            intel-compute-runtime
            intel-media-driver
          ];
          extraPackages32 = with pkgs.pkgsi686Linux; [
            intel-media-driver
          ];
        };
      }
    )
  ];
}
