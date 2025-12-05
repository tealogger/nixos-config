{ config, pkgs,... }:

{
    programs.fish =
    {
        enable = true;

        functions =
        {
            fish_greeting =
            {
                description = "Greeting to show when starting a fish shell";
                body = "fastfetch";
            };
        };

        shellAliases =
        let
            Default_Path = "~/Nixos";
        in
        {
            flup = "nix flake update ${Default_Path}";
            nxrb = "sudo nixos-rebuild switch --flake ${Default_Path}";
        };
    };
}
