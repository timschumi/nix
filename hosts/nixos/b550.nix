{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    (inputs.self + "/modules/variant-desktop.nix")
    (inputs.self + "/modules/adb.nix")
    (inputs.self + "/modules/comma.nix")
    (inputs.self + "/modules/discord.nix")
    (inputs.self + "/modules/firefox.nix")
    (inputs.self + "/modules/home.nix")
    (inputs.self + "/modules/libvirt.nix")
    (inputs.self + "/modules/lutris.nix")
    (inputs.self + "/modules/opentabletdriver.nix")
    (inputs.self + "/modules/plasma.nix")
    (inputs.self + "/modules/pipewire.nix")
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

        boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
        boot.initrd.kernelModules = [];
        boot.kernelModules = ["kvm-amd"];
        boot.extraModulePackages = [];

        fileSystems."/" = {
          device = "/dev/disk/by-uuid/eab1d084-c5f6-4506-b4e7-26eabd591900";
          fsType = "ext4";
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/7F63-E58C";
          fsType = "vfat";
          options = ["fmask=0022" "dmask=0022"];
        };

        fileSystems."/mnt/data1" = {
          device = "/dev/disk/by-uuid/ef261801-13a0-4f03-9713-93cf49808480";
          fsType = "ext4";
        };

        swapDevices = [];

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = true;

        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        networking.hostName = "b550";
      }
    )
  ];
}
