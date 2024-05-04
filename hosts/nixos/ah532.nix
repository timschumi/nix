{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    (inputs.self + "/modules/host-ah532.nix")
    (inputs.self + "/modules/variant-desktop.nix")
  ];
}
