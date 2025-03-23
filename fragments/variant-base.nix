{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      require-sigs = false;
    };
    registry = {
      self.flake = inputs.self;
    };
  };
  system.rebuild.enableNg = true;
  networking.nftables.enable = true;

  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de-latin1-nodeadkeys";
  };

  users.users.tim = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      htop
      silver-searcher
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFWSvBiQLNvqFY4iCzJ7scnstK872QOS5VtzuyXlXNzV"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMVEVylmxWUFCRuBOCz0wTjwfjot649TDoH9hQIWflXZ"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHInF0SYfQJGDv0w09UgbZv+cr1Ot2CsBn2kjFXflIY1"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFOP8+vneV/IeyBv+JmfT/GaO6RJP9sWayVSrc3paziQ"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIESy0Dg/XlF9nE27enyHp9l3YHMEmx0eckbnxt4iHThA"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIO5h6N1XE2wls4aqdzzpnPgIq7XlPwz/xMYxHgu5tduhAAAABHNzaDo="
    ];
  };

  users.users.root = {
    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIO5h6N1XE2wls4aqdzzpnPgIq7XlPwz/xMYxHgu5tduhAAAABHNzaDo="
    ];
  };

  services.openssh.enable = true;

  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
  };

  services.cron = {
    enable = true;
  };

  system.stateVersion = "23.11";

  # TODO: Find a better place for overlays.
  nixpkgs.overlays = [
    # FIXME: #389211
    (final: prev: {
      lklWithFirewall = prev.lklWithFirewall.overrideAttrs (
        finalAttrs: previousAttrs: {
          src = final.fetchFromGitHub {
            owner = "lkl";
            repo = "linux";
            rev = "fd33ab3d21a99a31683ebada5bd3db3a54a58800";
            sha256 = "sha256-3uPkOyL/hoA/H2gKrEEDsuJvwOE2x27vxY5Y2DyNNxU=";
          };
          version = "2025-03-20";
          buildInputs = [
            final.fuse3
            final.libarchive
          ];
        }
      );
      lkl = prev.lkl.overrideAttrs (
        finalAttrs: previousAttrs: {
          src = final.fetchFromGitHub {
            owner = "lkl";
            repo = "linux";
            rev = "fd33ab3d21a99a31683ebada5bd3db3a54a58800";
            sha256 = "sha256-3uPkOyL/hoA/H2gKrEEDsuJvwOE2x27vxY5Y2DyNNxU=";
          };
          version = "2025-03-20";
          buildInputs = [
            final.fuse3
            final.libarchive
          ];
        }
      );
    })
  ];
}
