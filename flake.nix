{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
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
          ./modules/host-ah532.nix
          ./modules/variant-desktop.nix
        ];
      };

      nixosConfigurations.d800 = mkNixosSystem {
        system = "i686-linux";
        modules = [
          ./modules/host-d800.nix
          ./modules/variant-desktop.nix
        ];
      };

      nixosConfigurations.d800jr = mkNixosSystem {
        system = "i686-linux";
        modules = [
          ./modules/host-d800jr.nix
          ./modules/variant-desktop.nix
        ];
      };

      nixosConfigurations.m600 = mkNixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/host-m600.nix
          ./modules/variant-desktop.nix
        ];
      };

      nixosConfigurations.p2520la = mkNixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/host-p2520la.nix
          ./modules/variant-desktop.nix
          ./modules/comma.nix
          ./modules/home.nix
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
