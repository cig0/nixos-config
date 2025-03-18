/*
  'pkgs' follows the nixpkgs.url attribute defined in the flake input,usually set to track the stable channel.

  If for any reason I want to assemble a NixOS generation from the unstable channel,
  by changing the channel in the nixpkgs.url input automatically cascade everything to 'pkgs'.

  There's no need to do any more work here as these dependencies automatically adjust to NixOS channel.
*/

{
  config,
  lib,
  pkgs,
  ...
}:
let
  # `myOptions` defines shared settings used by many modules; they live in `./nixos/modules/common/`
  cfg = config.mySystem.myOptions;
in
{
  # Intel iGPU hosts
  nixpkgs.config = (
    lib.mkIf (cfg.hardware.gpu == "intel") {
      packageOverrides = pkgs: {
        intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
      };
    }
  );

  hardware.graphics = (
    lib.mkIf (cfg.hardware.gpu == "intel") {
      enable = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-ocl
        intel-media-driver
        libvdpau-va-gl
        libdrm
        libGL
        mesa
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
      ];
    }
  );

  services.xserver.videoDrivers =
    if cfg.hardware.gpu == "intel" then
      [
        "modesetting"
        "fbdev"
      ]
    else if cfg.hardware.gpu == "nvidia" then
      [ "nvidia" ]
    else
      throw "Hostname '${config.networking.hostName}' hardware does not support the GPU architecture '${cfg.hardware.gpu}'!";

  # Nvidia GPU host
  # This is one way to do this. If `cfg.hardware.gpu` matches nvidia then the NixOS option is set to true, otherwise it remains unchanged.
  # This method also needs the `lib` input.
  hardware.nvidia.modesetting.enable = lib.mkIf (cfg.hardware.gpu == "nvidia") true;

  # This is another way to do this, simpler and concise, but with a slightly different behavior.
  # If `cfg.hardware.gpu` matches nvidia then the NixOS option is set to true, otherwise it is set to false.
  # hardware.nvidia.modesetting.enable = cfg.hardware.gpu == "nvidia";
}
