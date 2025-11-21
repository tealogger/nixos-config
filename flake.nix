{
  description = "System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

#    lanzaboote = {
#      url = "github:nix-community/lanzaboote/v0.4.3";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

#     niri = {
#       url = "github:sodiboo/niri-flake";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#
#     quickshell = {
#       url = "github:outfoxxed/quickshell";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#
#     dgop = {
#       url = "github:AvengeMedia/dgop";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#
#     dankMaterialShell = {
#       url = "github:AvengeMedia/DankMaterialShell";
#       inputs.nixpkgs.follows = "nixpkgs";
#       inputs.dgop.follows = "dgop";
#     };
  };

  outputs = { self, nixpkgs,home-manager, stylix, ...}@inputs :
    let
        system = "x86_64-linux";
#         pkgs = nixpkgs.legacyPackages.${system};
        pkgs = import nixpkgs {
          inherit system;
        };
    in
    {
      nixosConfigurations = {
        lenlap = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            stylix.nixosModules.stylix
            ./hosts/lenlap/configuration.nix
#            lanzaboote.nixosModules.lanzaboote

#            ({ pkgs, lib, ... }: {
#
#              environment.systemPackages = [
#                pkgs.sbctl
#              ];
#
#              boot.loader.systemd-boot.enable = lib.mkForce false;
#
#              boot.lanzaboote = {
#                enable = true;
#                pkiBundle = "/var/lib/sbctl";
#              };
#            })
          ];
        };

#         new = nixpkgs.lib.nixosSystem {
#
#         };


      };

      homeConfigurations."x" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; };
        inherit pkgs;
        modules = [
          ./hosts/lenlap/home.nix
        ];
      };

    };
}
