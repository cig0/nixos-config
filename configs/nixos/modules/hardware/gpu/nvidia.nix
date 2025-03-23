{
  config,
  lib,
  pkgsUnstable,
  ...
}:

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

  config = lib.mkIf (cfg.myOptions.hardware.gpu == "nvidia") {

    # Additional module packages
    mySystem.myOptions.packages.modulePackages = with pkgsUnstable; [
      nvtopPackages.nvidia
    ];

    hardware = {
      nvidia-container-toolkit.enable = cfg.hardware.nvidia-container-toolkit.enable;
      graphics.enable = true;

      nvidia = {
        open = false;
        dynamicBoost.enable = true;
        modesetting.enable = true; # TODO: remove the modesetting option from module kernel.nix?
        powerManagement = {
          enable = true;
          finegrained = false;
        };
      };
    };
  };
}
