{
  config,
  lib,
  myArgs,
  pkgs,
  ...
}:
{
  options.mySystem.hardware.nvidia-container-toolkit.enable =
    lib.mkEnableOption "Enable dynamic CDI configuration for Nvidia devices by running nvidia-container-toolkit on boot.";

  config = lib.mkIf (config.mySystem.myOptions.hardware.gpu == "nvidia") {

    # Additional module packages
    mySystem.myOptions.packages.modulePackages = with myArgs.packages.pkgsUnstable; [
      nvtopPackages.nvidia
    ];

    hardware = {
      graphics = lib.mkIf config.mySystem.hardware.graphics.enable {
        enable = true;
        extraPackages = with pkgs; [
          libva-utils
          nvidia-vaapi-driver
          vaapiVdpau
          vdpauinfo
        ];
      };

      nvidia-container-toolkit.enable = config.mySystem.hardware.nvidia-container-toolkit.enable;

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

    services.xserver.videoDrivers = [
      "nvidia"
    ];
  };
}
