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
    programs.plasma.workspace.cursor.theme = "Breeze";
    programs.plasma.workspace.iconTheme = "breeze";
    programs.plasma.workspace.wallpaper = "${pkgs.plasma-workspace-wallpapers}/share/wallpapers/Kay/contents/images_dark/5120x2880.png";

    programs.plasma.powerdevil.AC.autoSuspend.action = "nothing";

    programs.plasma.configFile."kxkbrc"."Layout"."LayoutList" = "de";
    programs.plasma.configFile."kxkbrc"."Layout"."Use" = true;
    programs.plasma.configFile."kxkbrc"."Layout"."VariantList" = "nodeadkeys";

    programs.plasma.configFile."baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
    programs.plasma.configFile."krunnerrc"."Plugins"."baloosearchEnabled" = false;
  };

  # Substitute lacking KIO functions with GVFS (in particular support for mounting avahi/dnssd/webdav).
  services.gvfs.enable = true;
  services.gvfs.package = pkgs.gvfs.override {
    avahi = pkgs.avahi; # Required for webdav
    samba = null;
    gnomeSupport = true; # Required for TLS support
    udevSupport = true; # Required for FUSE support
  };
}
