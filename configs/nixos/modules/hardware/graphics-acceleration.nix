{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.mySystem.hardware.graphics.enable =
    lib.mkEnableOption "Whether to enable hardware accelerated graphics drivers.

This is required to allow most graphical applications and environments to use hardware rendering, video encode/decode acceleration, etc.

This option should be enabled by default by the corresponding modules, so you do not usually have to set it yourself.";

  config = {
    nixpkgs.config = (
      lib.mkIf (config.mySystem.myOptions.hardware.gpu == "intel") {
        packageOverrides = pkgs: {
          intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
        };
      }
    );

    hardware.graphics = lib.mkIf config.mySystem.hardware.graphics.enable {
      enable = true;
      extraPackages =
        lib.optionals (config.mySystem.myOptions.hardware.gpu == "intel") (
          with pkgs;
          [
            intel-compute-runtime
            intel-ocl
            intel-media-driver
            libvdpau-va-gl
            libdrm
            libGL
            mesa
          ]
        )
        ++ lib.optionals (config.mySystem.myOptions.hardware.gpu == "nvidia") (
          with pkgs;
          [
            libva-utils
            nvidia-vaapi-driver
            vaapiVdpau
            vdpauinfo
          ]
        );
      extraPackages32 =
        lib.optionals (config.mySystem.myOptions.hardware.gpu == "intel") (
          with pkgs.pkgsi686Linux;
          [
            intel-media-driver
          ]
        )
        ++ lib.optionals (config.mySystem.myOptions.hardware.gpu == "nvidia") (
          with pkgs.pkgsi686Linux;
          [
          ]
        );
    };

    services.xserver.videoDrivers =
      lib.mkIf (config.mySystem.myOptions.hardware.gpu == "intel") ([
        "modesetting"
        "fbdev"
      ])
      // lib.mkIf (config.mySystem.myOptions.hardware.gpu == "nvidia") ([
        "nvidia"
      ]);
  };
}
