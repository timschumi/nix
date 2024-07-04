{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    (inputs.self + "/modules/variant-desktop.nix")
    (inputs.self + "/modules/adb.nix")
    (inputs.self + "/modules/comma.nix")
    (inputs.self + "/modules/discord.nix")
    (inputs.self + "/modules/firefox.nix")
    (inputs.self + "/modules/home.nix")
    (inputs.self + "/modules/jetbrains.nix")
    (inputs.self + "/modules/libvirt.nix")
    (inputs.self + "/modules/lutris.nix")
    (inputs.self + "/modules/opentabletdriver.nix")
    (inputs.self + "/modules/plasma.nix")
    (inputs.self + "/modules/pipewire.nix")
    (inputs.self + "/modules/podman.nix")
    (inputs.self + "/modules/spotify.nix")
    (inputs.self + "/modules/steam.nix")
    (inputs.self + "/modules/thunderbird.nix")

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
