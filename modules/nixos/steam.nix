{ config, pkgs,... }:

{
    programs.steam = {
    enable = true;

    extraPackages = with pkgs;
      [kdePackages.breeze];

    gamescopeSession.enable = true;
    };
}
