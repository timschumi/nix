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
    nixosConfigurations.ah532 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./host/ah532.nix
        ./variant/desktop.nix
      ];
    };

    nixosConfigurations.d800 = nixpkgs.lib.nixosSystem {
      system = "i686-linux";
      modules = [
        ./host/d800.nix
        ./variant/desktop.nix
      ];
    };

    nixosConfigurations.d800jr = nixpkgs.lib.nixosSystem {
      system = "i686-linux";
      modules = [
        ./host/d800jr.nix
        ./variant/desktop.nix
      ];
    };

    nixosConfigurations.m600 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./host/m600.nix
        ./variant/desktop.nix
      ];
    };

    nixosConfigurations.p2520la = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./host/p2520la.nix
        ./variant/desktop.nix
      ];
    };

    formatter = {
      i686-linux = nixpkgs.legacyPackages.i686-linux.alejandra;
      x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
      aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.alejandra;
    };
  };
}
