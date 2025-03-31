/*
  TODO_
  NixOS Options
  ────────────────────
  # hardware.nvidia.powerManagement.enable
  Whether to enable experimental power management through systemd. For more information, see
  the NVIDIA docs, on Chapter 21. Configuring Power Management Support
  .
  type: boolean
*/
{
  config,
  lib,
  myArgs,
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
    mySystem.myOptions.packages.modulePackages = with myArgs.packages.pkgsUnstable; [
      nvtopPackages.nvidia
    ];

    hardware = {
      nvidia-container-toolkit.enable = cfg.hardware.nvidia-container-toolkit.enable;

      nvidia = {
        open = true;
        dynamicBoost.enable = false;
        modesetting.enable = true;
        nvidiaSettings = true;
        powerManagement = {
          enable = true;

          /*
            Fine-grained power management. Turns off GPU when not in use.
            Experimental and only works on modern Nvidia GPUs (Turing or newer).
          */
          finegrained = false;
        };
      };
    };
  };
}
