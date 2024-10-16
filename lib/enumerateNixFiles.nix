{inputs}: let
  inherit (builtins) attrNames map readDir;
  inherit (inputs.nixpkgs.lib.strings) removeSuffix;
  inherit (inputs.nixpkgs.lib.attrsets) filterAttrs genAttrs;
in
  directory: let
    regularFiles = attrNames (filterAttrs (path: type: type == "regular") (readDir directory));
  in
    genAttrs (map (removeSuffix ".nix") regularFiles) (stem: "${directory}/${stem}.nix")
