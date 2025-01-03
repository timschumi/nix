{
  inputs,
  pkgs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_full.override {
        # FIXME: Required due to ceph build failure via python3.11-trustme (#359723/#369777).
        cephSupport = false;
      };
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          })
          .fd
        ];
      };
    };
  };

  users.users.tim = {
    extraGroups = ["libvirtd"];
  };

  home-manager.users.tim = {
    home.packages = with pkgs; [
      virt-manager
    ];
  };
}
