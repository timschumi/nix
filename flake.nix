{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    flake-utils,
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
  }
  // (flake-utils.lib.eachSystem flake-utils.lib.allSystems (system: let
    pkgs = import nixpkgs {inherit system;};
  in {
    formatter = pkgs.alejandra;
  }));
}
