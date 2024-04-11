{
  config,
  lib,
  pkgs,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.require-sigs = false;

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = builtins.elem pkgs.system ["i686-linux" "x86_64-linux"];
  hardware.cpu.intel.updateMicrocode = builtins.elem pkgs.system ["i686-linux" "x86_64-linux"];

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de-latin1-nodeadkeys";
  };

  users.users.tim = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [
      git
      htop
      vim
    ];
  };

  services.openssh.enable = true;

  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
  };

  system.stateVersion = "23.11";
}
