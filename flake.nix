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

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
  };

  outputs = { self, nixpkgs, home-manager, ...}@inputs :
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        lenlap = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ./configuration.nix
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
      };

      homeConfigurations."x" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; };
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
