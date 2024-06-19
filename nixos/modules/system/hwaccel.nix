# Hardware acceleration

{ config, lib, pkgs, ... }:

let
  hostnameLogic = import ../../helpers/hostnames.nix { inherit config lib; };
in
{
  # Intel iGPU hosts
  nixpkgs.config = hostnameLogic.mkIf hostnameLogic.isIntelGPUHost {
    packageOverrides = pkgs: {
      intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    };
  };

  hardware.opengl = hostnameLogic.mkIf hostnameLogic.isIntelGPUHost {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-ocl
      intel-media-driver  # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver  # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
      libdrm
      libGL
      mesa
    ];
  };

  services.xserver.videoDrivers =
    hostnameLogic.mkIf hostnameLogic.isIntelGPUHost [ "modesetting" "fbdev" ] ++
    hostnameLogic.mkIf hostnameLogic.isVittusaatana [ "nvidia" ];

  # ===== FOR WHEN MIGRATING VITTU
  # Nvidia GPU host
  hardware.nvidia.modesetting.enable = hostnameLogic.mkIf hostnameLogic.isVittusaatana true;
}