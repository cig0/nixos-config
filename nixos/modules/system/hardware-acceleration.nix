{
  config,
  lib,
  pkgs,
  pkgsUnstable,
  ...
}:
let
  # `myOptions` defines shared settings used by many modules; they live in `./nixos/modules/common/`
  cfg = config.mySystem.myOptions;

  # Select the channel based on currentChannelInUse
  channelPkgs = if cfg.nixos.channelPkgs == "stable" then pkgs else pkgsUnstable;
in
{
  # Define packageOverrides without recursion
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver =
      # Use pkgs as default, override only if needed
      if cfg.hardware.gpu == "intel" then
        (if cfg.nixos.channelPkgs == "stable" then pkgs else pkgsUnstable).intel-vaapi-driver.override {
          enableHybridCodec = true;
        }
      else
        pkgs.intel-vaapi-driver;
  };

  hardware.graphics = lib.mkIf (cfg.hardware.gpu == "intel") {
    enable = true;
    extraPackages = with channelPkgs; [
      intel-compute-runtime
      intel-ocl
      intel-media-driver
      libvdpau-va-gl
      libdrm
      libGL
      mesa
    ];
    extraPackages32 = with channelPkgs.pkgsi686Linux; [
      intel-media-driver
    ];
  };

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
  # This is one way to do this. If `cfg.gpu` matches nvidia then the NixOS option is set to true, otherwise it remains unchanged.
  # This method also needs the `lib` input.
  hardware.nvidia.modesetting.enable = lib.mkIf (cfg.hardware.gpu == "nvidia") true;

  # This is another way to do this, simpler and concise, but with a slightly different behavior.
  # If `cfg.gpu` matches nvidia then the NixOS option is set to true, otherwise it is set to false.
  # I'm fine with this resolution for this use case. And it is even more idiomatic ^_^.
  # hardware.nvidia.modesetting.enable = cfg.hardware.gpu == "nvidia";
}
