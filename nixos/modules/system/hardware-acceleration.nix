{
  config,
  pkgs, # TODO: I should consider an abstraction layer for pkgs to make it easier to switch between the stable and unstable release channel for the base system in case I need to. By hard-coding below `pkgs.intel-vaapi-driver.override` (similarly as I do in a few of other modules), I risk from collision of packages to make my NixOS generation way bigger than necessary. By implementing here an alternative input, e.g. `currentChannelInUse.intel-vaapi-driver.override`, I could easily switch between the stable and unstable release channel for the base system while ensuring the change would cascade to all the appropriate places. I should also create an option to easily manage currentChannelInUse from a host-options.nix file.
  pkgsUnstable,
  ...
}:
let
  # customOptions.hardware.gpu is part of a super-option set used by at least three different modules.
  # As such, it is defined in `./nixos/modules/common/`.
  cfg.gpu = config.mySystem.customOptions.hardware.gpu;
in
{
  # Intel iGPU hosts
  nixpkgs.config =
    if cfg.gpu == "intel" then
      {
        packageOverrides = pkgs: {
          intel-vaapi-driver =
            "${config.mySystem.customOptions.nixos.currentChannelInUse}.intel-vaapi-driver.override"
              { enableHybridCodec = true; };
        };
      }
    else
      { };

  hardware.graphics =
    if cfg.gpu == "intel" then
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
    if cfg.gpu == "intel" then
      [
        "modesetting"
        "fbdev"
      ]
    else if cfg.gpu == "nvidia" then
      [ "nvidia" ]
    else
      throw "Hostname '${config.networking.hostName}' hardware does not support the GPU architecture '${cfg.gpu}'!";

  # Nvidia GPU host

  # This is one way to do this. If `cfg.gpu` matches nvidia then the NixOS option is set to true, otherwise it remains unchanged.
  # This method also needs the `lib` input.
  # hardware.nvidia.modesetting.enable = lib.mkIf (cfg.gpu == "nvidia") true;

  # This is another way to do this, simpler and concise, but with a slightly different behavior.
  # If `cfg.gpu` matches nvidia then the NixOS option is set to true, otherwise it is set to false.
  # I'm fine with this resolution for this use case. And it is even more idiomatic ^_^.
  hardware.nvidia.modesetting.enable = cfg.gpu == "nvidia";
}
