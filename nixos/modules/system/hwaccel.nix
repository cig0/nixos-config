# Hardware acceleration

{ config, lib, pkgs, ... }:

let
  hostSelector = import ../../lib/host-selector.nix { inherit config lib; };
in
{
  # Intel iGPU hosts
  nixpkgs.config = hostSelector.mkIf hostSelector.isIntelGPUHost {
    packageOverrides = pkgs: {
      intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    };
  };

   hardware.graphics = hostSelector.mkIf hostSelector.isIntelGPUHost {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-ocl
      intel-media-driver  # LIBVA_DRIVER_NAME=iHD
      libvdpau-va-gl
      libdrm
      libGL
      mesa
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      #intel-vaapi-driver
    ];
  };

  services.xserver.videoDrivers =
    if hostSelector.isIntelGPUHost then [ "modesetting" "fbdev" ]
    else if hostSelector.isNvidiaGPUHost then [ "nvidia" ]
    else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";

  # ===== FOR WHEN MIGRATING VITTU
  # Nvidia GPU host
  hardware.nvidia.modesetting.enable = hostSelector.mkIf hostSelector.isNvidiaGPUHost true;
}
