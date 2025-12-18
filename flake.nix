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
  };

  outputs = { self, nixpkgs, home-manager, ...}:
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
          ];

        };
      };
    };
}
