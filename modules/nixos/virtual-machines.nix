{ config, pkgs,... }:

{
    virtualisation =
    {
        libvirtd.enable = true;
        waydroid =
        {
            enable = true;
            package = pkgs.waydroid-nftables;
        };
    };
    programs.virt-manager.enable = true;
}
