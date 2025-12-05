{ config, pkgs,... }:

{
  home.packages = with pkgs;[
    sbctl
    brave
    alacritty
    vesktop
    telegram-desktop
    fastfetch
    obsidian
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
    btop
    kdePackages.isoimagewriter
    devenv
    kdePackages.kolourpaint
  ];
}
