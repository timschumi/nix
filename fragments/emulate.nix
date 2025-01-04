systems:
{
  inputs,
  pkgs,
  ...
}:
{
  boot.binfmt.emulatedSystems = systems;
  nix.settings.extra-platforms = systems;
}
