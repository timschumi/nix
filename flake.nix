{
  description = "NixOS";

  inputs = {
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = {
    flake-utils,
    nixpkgs,
    self,
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
          nixpkgs.lib.attrsets.recursiveUpdate commonSettings (import (hostsDir + ("/" + file)) commonSettings.specialArgs)
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
