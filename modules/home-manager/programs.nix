{ config, pkgs,... }:

{
#   programs.steam = {
#     enable = true;
#
#     extraPackages = with pkgs;
#       [kdePackages.breeze];
#
#     gamescopeSession.enable = true;
#   };
#   programs.gamemode.enable = true;

  home.packages = with pkgs;[
    sbctl
    brave
    alacritty
    vesktop
    telegram-desktop
    fastfetch
    #obsidian
    vscode
    cmatrix
    mangohud
    prismlauncher
    cava
    obs-studio
    blanket
    osu-lazer-bin
    protonvpn-gui
    onlyoffice-desktopeditors
    peaclock
  ];
}
