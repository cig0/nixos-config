{
  config,
  pkgs,
  ...
}:
let
  hostSelector = import ../host-selector.nix { inherit config; }; # TODO: remove this legacy selector
in
{
  # Intel iGPU hosts
  nixpkgs.config =
    if hostSelector.isIntelGPUHost then
      {
        packageOverrides = pkgs: {
          intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
        };
      }
    else
      { };

  hardware.graphics =
    if hostSelector.isIntelGPUHost then
      {
        enable = true;
        extraPackages = with pkgs; [
          intel-compute-runtime
          intel-ocl
          intel-media-driver # LIBVA_DRIVER_NAME=iHD
          libvdpau-va-gl
          libdrm
          libGL
          mesa
        ];
        extraPackages32 = with pkgs.pkgsi686Linux; [
          intel-media-driver
          #intel-vaapi-driver
        ];
      }
    else
      { };

  services.xserver.videoDrivers =
    if hostSelector.isIntelGPUHost then
      [
        "modesetting"
        "fbdev"
      ]
    else if hostSelector.isNvidiaGPUHost then
      [ "nvidia" ]
    else
      throw "Hostname '${config.networking.hostName}' does not match any expected hosts!";

  # Nvidia GPU host
  hardware.nvidia.modesetting.enable = hostSelector.mkIf hostSelector.isNvidiaGPUHost true;
}
