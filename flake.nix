{
  description = "NixOS";

  inputs = {
    devshell = {
      url = "github:numtide/devshell";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

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
    devshell,
    flake-utils,
    nixpkgs,
    self,
    ...
  } @ inputs:
    {}
    # Load all nixos hosts and apply common settings.
    // (let
      commonSettings = {
        specialArgs = {
          inherit inputs;
        };
      };
      hosts = self.lib.enumerateNixFiles ./hosts/nixos;
      outputs = self.lib.enumerateNixFiles ./outputs;
      loadHost = hostpath: nixpkgs.lib.attrsets.recursiveUpdate commonSettings (import hostpath commonSettings.specialArgs);
      cartesian = nixpkgs.lib.attrsets.cartesianProduct {
        host = nixpkgs.lib.attrsToList hosts;
        output = [null] ++ nixpkgs.lib.attrsToList outputs;
      };
      assemble = {
        host,
        output,
      }: let
        configurationName =
          host.name
          + (
            if output != null
            then "+${output.name}"
            else ""
          );
        configurationBase = loadHost host.value;
        configuration =
          configurationBase
          // {
            modules =
              configurationBase.modules
              ++ (
                if output != null
                then [output.value]
                else []
              );
          };
      in
        nixpkgs.lib.nameValuePair configurationName (nixpkgs.lib.nixosSystem configuration);
    in {
      nixosConfigurations = nixpkgs.lib.listToAttrs (map assemble cartesian);
    })
    # Add all global devshells.
    // (let
      shells = self.lib.enumerateNixFiles ./shells;
      loadShell = shellpath: system:
        import shellpath {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              devshell.overlays.default
            ];
          };
        };
    in {
      devShells = flake-utils.lib.eachSystemMap flake-utils.lib.allSystems (
        system: nixpkgs.lib.mapAttrs (shell: shellpath: loadShell shellpath system) shells
      );
    })
    # Set formatters for all architectures.
    // (flake-utils.lib.eachSystem flake-utils.lib.allSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      formatter = pkgs.alejandra;
    }))
    # Extra attrset entries that are not generated.
    // {
      lib = import ./lib {
        inherit inputs;
      };
    };
}
