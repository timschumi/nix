{
  pkgs,
  inputs,
  ...
}: {
  home-manager.users.tim = {
    home.packages = with pkgs; [
      (lutris.override {
        extraPkgs = pkgs: [
          wine-staging
        ];
      })
    ];
  };
}
