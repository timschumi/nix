{
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (builtins) attrNames concatMap foldl' map readDir;
  inherit (inputs.nixpkgs.lib) filterAttrs removeSuffix;
  inherit (inputs.nixpkgs.lib.options) mkEnableOption mkOption;
  inherit (inputs.nixpkgs.lib.types) listOf nullOr str;
  usersDir = ./user;
  users = map (removeSuffix ".nix") (attrNames (filterAttrs (path: type: type == "regular") (readDir usersDir)));
  rolesDir = ./role;
  roles = map (removeSuffix ".nix") (attrNames (filterAttrs (path: type: type == "regular") (readDir rolesDir)));
in {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
    ]
    ++ concatMap (
      user:
        [
          (import (usersDir + ("/" + user + ".nix")) {
            inherit user;
          })
        ]
        ++ map (role:
          import (rolesDir + ("/" + role + ".nix")) {
            inherit role user;
          })
        roles
    )
    users;

  options.extra.user = foldl' (a: b: a // b) {} (map (user: {
      "${user}" = {
        enable =
          mkEnableOption "Create user ${user}"
          // {
            default = config.extra.user."${user}".roles != null;
          };
        roles = mkOption {
          default = null;
          example = roles;
          type = nullOr (listOf str);
        };
      };
    })
    users);
}
