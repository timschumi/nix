systems: {
  pkgs,
  inputs,
  ...
}: {
  boot.binfmt.emulatedSystems = systems;
  nix.settings.extra-platforms = systems;
}
