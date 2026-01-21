{ config, pkgs,... }:

{
    boot.loader =
    {
        timeout = 5;
        limine =
        {
            enable = true;
            secureBoot.enable = true;
            style =
            {
                wallpapers =
                [
                    ../../modules/themes/wallpapers/flee_puny_mortals_fleeeee__by_neytirix_desjf2j.jpg
                ];
                interface.branding = "I use Nixos BTW!!!";
            };
        };

        efi.canTouchEfiVariables = true;
    };
}
