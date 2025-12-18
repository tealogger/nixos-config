{
  description = "System Flake";

  inputs =
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager =
    {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote =
    {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, lanzaboote, ...}:
    let
        system = "x86_64-linux";
    in
    {
      nixosConfigurations =
      {
        lenlap = nixpkgs.lib.nixosSystem
        {
          inherit system;

          modules =
          [
            ./hosts/lenlap/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.x = ./hosts/lenlap/home.nix;
            }

            lanzaboote.nixosModules.lanzaboote
            ({ pkgs, lib, ... }:
            {

              environment.systemPackages =
              [
                pkgs.sbctl
              ];

              boot.loader.systemd-boot.enable = lib.mkForce false;

              boot.lanzaboote =
              {
                enable = true;
                pkiBundle = "/var/lib/sbctl";
              };
            })
          ];

        };
      };
    };
}
