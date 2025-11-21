{ config, pkgs,... }:

{
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
  hardware.nvidia.open = true;

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };

    # integrated
    # intelBusId = "PCI:0:0:0";
    amdgpuBusId = "PCI:5:0:0";

    # dedicated
    nvidiaBusId = "PCI:1:0:0";
  };
}
