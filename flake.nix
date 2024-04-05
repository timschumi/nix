{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.d800 = nixpkgs.lib.nixosSystem {
      system = "i686-linux";
      modules = [
        ./d800-configuration.nix
      ];
    };

    nixosConfigurations.m600 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./m600-configuration.nix
      ];
    };

    formatter = {
      i686-linux = nixpkgs.legacyPackages.i686-linux.alejandra;
      x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    };
  };
}
