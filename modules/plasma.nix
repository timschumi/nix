{
  pkgs,
  inputs,
  ...
}: {
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  home-manager.users.tim = {
    imports = [
      inputs.plasma-manager.homeManagerModules.plasma-manager
    ];

    programs.plasma.enable = true;
    programs.plasma.workspace.clickItemTo = "select";
    programs.plasma.workspace.lookAndFeel = "org.kde.breezedark.desktop";
    programs.plasma.workspace.cursorTheme = "Breeze";
    programs.plasma.workspace.iconTheme = "breeze";
    programs.plasma.workspace.wallpaper = "${pkgs.plasma-workspace-wallpapers}/share/wallpapers/Kay/contents/images_dark/5120x2880.png";
  };
}
