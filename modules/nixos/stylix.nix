{ config, pkgs,... }:

{
    stylix = {
        enable = true;

        base16Scheme = {
            base00 = "#000000";
            base01 = "#121212";
            base02 = "#222222";
            base03 = "#333333";
            base04 = "#999999";
            base05 = "#c1c1c1";
            base06 = "#999999";
            base07 = "#c1c1c1";
            base08 = "#8A3F3F";
            base09 = "#aaaaaa";
            base0A = "#a06666";
            base0B = "#dd9999";
            base0C = "#aaaaaa";
            base0D = "#8A3F3F";
            base0E = "#999999";
            base0F = "#444444";
        };

        polarity = "dark";

        image = ./96YOTTEA_on_Pixiv_looking.png;
    };
}
