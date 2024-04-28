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
  } @ inputs: let
    mkNixosSystem = config:
      nixpkgs.lib.nixosSystem (
        config
        // {
          specialArgs = {
            inherit inputs;
          };
        }
      );
  in
    {
      nixosConfigurations.ah532 = mkNixosSystem {
        system = "x86_64-linux";
        modules = [
          ./host/ah532.nix
          ./variant/desktop.nix
        ];
      };

      nixosConfigurations.d800 = mkNixosSystem {
        system = "i686-linux";
        modules = [
          ./host/d800.nix
          ./variant/desktop.nix
        ];
      };

      nixosConfigurations.d800jr = mkNixosSystem {
        system = "i686-linux";
        modules = [
          ./host/d800jr.nix
          ./variant/desktop.nix
        ];
      };

      nixosConfigurations.m600 = mkNixosSystem {
        system = "x86_64-linux";
        modules = [
          ./host/m600.nix
          ./variant/desktop.nix
        ];
      };

      nixosConfigurations.p2520la = mkNixosSystem {
        system = "x86_64-linux";
        modules = [
          ./host/p2520la.nix
          ./variant/desktop.nix
          ./modules/plasma.nix
          ./modules/pipewire.nix
        ];
      };
    }
    // (flake-utils.lib.eachSystem flake-utils.lib.allSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      formatter = pkgs.alejandra;
    }));
}
