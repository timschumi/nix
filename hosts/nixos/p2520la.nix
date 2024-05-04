{inputs, ...}: {
  system = "x86_64-linux";
  modules = [
    (inputs.self + "/modules/host-p2520la.nix")
    (inputs.self + "/modules/variant-desktop.nix")
    (inputs.self + "/modules/comma.nix")
    (inputs.self + "/modules/home.nix")
    (inputs.self + "/modules/plasma.nix")
    (inputs.self + "/modules/pipewire.nix")
  ];
}
