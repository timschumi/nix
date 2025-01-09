{
  config,
  inputs,
  ...
}:
let
  inherit (builtins) elem;
  inherit (inputs.nixpkgs.lib.attrsets) attrValues;
  inherit (inputs.nixpkgs.lib.lists) filter flatten;
  inherit (inputs.nixpkgs.lib.options) mkOption;
  inherit (inputs.nixpkgs.lib.types) listOf str;
in
{
  options.extra.adminKeys = mkOption {
    type = listOf str;
    default =
      let
        users = attrValues config.users.users;
        isAdmin = (user: elem "wheel" user.extraGroups);
      in
      flatten (map (user: user.openssh.authorizedKeys.keys) (filter isAdmin users));
  };
}
