{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nur.url = github:nix-community/NUR;

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    ...
  } @ inputs:
    {}
    # Load all nixos hosts and apply common settings.
    // (let
      hostsDir = ./hosts/nixos;
      commonSettings = {
        specialArgs = {
          inherit inputs;
        };
      };
      hostFiles = builtins.attrNames (nixpkgs.lib.attrsets.filterAttrs (path: type: type == "regular") (builtins.readDir hostsDir));
      mergeSets = builtins.foldl' (acc: elem: acc // elem) {};
      hostNameFromFile = nixpkgs.lib.strings.removeSuffix ".nix";
      fileToConfiguration = file: {
        "${hostNameFromFile file}" = nixpkgs.lib.nixosSystem (
          (import (hostsDir + ("/" + file)) commonSettings.specialArgs) // commonSettings
        );
      };
    in {
      nixosConfigurations = mergeSets (builtins.map fileToConfiguration hostFiles);
    })
    # Set formatters for all architectures.
    // (flake-utils.lib.eachSystem flake-utils.lib.allSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      formatter = pkgs.alejandra;
    }));
}
