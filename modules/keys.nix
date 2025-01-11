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
  users = config.users.users;
  keysForUser = conf: conf.openssh.authorizedKeys.keys;
in
{
  options.extra.sudoerKeys = mkOption {
    type = listOf str;
    default =
      let
        isSudoer = user: elem "wheel" user.extraGroups || elem "sudo" user.extraGroups;
        sudoers = filter isSudoer (attrValues users);
        extractKeys = users: flatten (map keysForUser users);
      in
      extractKeys sudoers;
  };

  options.extra.rootKeys = mkOption {
    type = listOf str;
    default = config.extra.sudoerKeys ++ keysForUser users.root;
  };
}
