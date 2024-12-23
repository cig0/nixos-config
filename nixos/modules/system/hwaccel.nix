# Hardware acceleration

{ config, lib, pkgs, ... }:

let
  hosts = import ../../lib/hosts.nix { inherit config lib; };
in
{
  # Intel iGPU hosts
  nixpkgs.config = hosts.mkIf hosts.isIntelGPUHost {
    packageOverrides = pkgs: {
      intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    };
  };

   hardware.graphics = hosts.mkIf hosts.isIntelGPUHost {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-ocl
      intel-media-driver  # LIBVA_DRIVER_NAME=iHD
      # intel-vaapi-driver  # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
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
    if hosts.isIntelGPUHost then [ "modesetting" "fbdev" ]
    else if hosts.isNvidiaGPUHost then [ "nvidia" ]
    else throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";

  # ===== FOR WHEN MIGRATING VITTU
  # Nvidia GPU host
  hardware.nvidia.modesetting.enable = hosts.mkIf hosts.isNvidiaGPUHost true;
}
