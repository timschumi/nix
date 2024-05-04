{inputs, ...}: {
  system = "i686-linux";
  modules = [
    (inputs.self + "/modules/host-d800.nix")
    (inputs.self + "/modules/variant-desktop.nix")
  ];
}
