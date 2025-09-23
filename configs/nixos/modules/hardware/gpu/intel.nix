{
  config,
  lib,
  myArgs,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.myNixos.myOptions.hardware.gpu == "intel") {

    # Additional module packages
    myNixos.myOptions.packages.modulePackages = with myArgs.packages.pkgs-unstable; [
      nvtopPackages.intel
    ];

    hardware.graphics = lib.mkIf config.myNixos.hardware.graphics.enable {
      enable = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-ocl
        intel-media-driver
        libvdpau-va-gl
        libdrm
        libGL
        mesa
        vpl-gpu-rt
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
      ];
    };

    nixpkgs.config = {
      packageOverrides = pkgs: {
        intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
      };
    };

    services.xserver.videoDrivers = [
      "modesetting"
      "fbdev"
    ];
  };
}
