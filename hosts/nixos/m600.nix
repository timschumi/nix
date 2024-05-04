{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    (inputs.self + "/modules/host-m600.nix")
    (inputs.self + "/modules/variant-desktop.nix")
  ];
}
