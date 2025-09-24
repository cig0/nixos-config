{ config, lib, myArgs, pkgs, ... }: {
  options.myNixos.hardware.nvidia-container-toolkit.enable = lib.mkEnableOption
    "Enable dynamic CDI configuration for Nvidia devices by running nvidia-container-toolkit on boot.";

  config = lib.mkIf (config.myNixos.myOptions.hardware.gpu == "nvidia") {

    # Additional module packages
    myNixos.myOptions.packages.modulePackages =
      with myArgs.packages.pkgs-unstable;
      [ nvtopPackages.nvidia ];

    hardware = {
      graphics = lib.mkIf config.myNixos.hardware.graphics.enable {
        enable = true;
        extraPackages = with pkgs; [
          libva-utils
          nvidia-modprobe
          nvidia-vaapi-driver
          vaapiVdpau
          vdpauinfo
        ];
      };

      nvidia-container-toolkit.enable =
        config.myNixos.hardware.nvidia-container-toolkit.enable;

      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        open = true;
        dynamicBoost.enable = false;
        modesetting.enable = true;
        nvidiaSettings = true;
        powerManagement = {
          enable = true;

          /* Fine-grained power management. Turns off GPU when not in use.
             Experimental and only works on modern Nvidia GPUs (Turing or newer).
          */
          finegrained = false;
        };
      };
    };

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
