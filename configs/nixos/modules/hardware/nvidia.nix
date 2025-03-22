{ config, lib, ... }:

let
  cfg = config.mySystem;

in
{
  options.mySystem.hardware.nvidia-container-toolkit.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable dynamic CDI configuration for Nvidia devices by running
nvidia-container-toolkit on boot.";
  };

  config =
    lib.mkIf cfg.hardware.gpu == "nvidia" {

      hardware = {
        nvidia-container-toolkit.enable = cfg.hardware.nvidia-container-toolkit.enable;
        opengl.enable = true;

        nvidia = {
          open = false;
          dynamicBoost.enable = true;
          modesetting.enable = true; # TODO: remove the modesetting option from module kernel.nix?
          powerManagement.enable = true;
          prime = {
            sync.enable = false;

            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
            #amdgpuBusId = "PCI:54:0:0"; # If you have an AMD iGPU
          };
        };
      };
    };
}
