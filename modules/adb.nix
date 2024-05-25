{
  pkgs,
  inputs,
  ...
}: {
  programs.adb.enable = true;
  users.users.tim.extraGroups = ["adbusers"];
}
