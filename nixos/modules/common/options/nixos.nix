{
  lib,
  ...
}:
{
  options.mySystem.customOptions.nixos.currentChannelInUse = lib.mkOption {
    type = lib.types.enum [
      "pkgs"
      "pkgsUnstable"
    ];
    default = null;
    description = "Channel to use for the NixOS base system, package overrides, and supporting packages.";
  };
}
