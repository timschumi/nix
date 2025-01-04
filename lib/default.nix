{ inputs }:
let
  importWithInherit =
    path:
    import path {
      inherit inputs;
    };
in
{
  enumerateNixFiles = importWithInherit ./enumerateNixFiles.nix;
}
