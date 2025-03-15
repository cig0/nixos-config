{
  lib,
  ...
}:
{
  options.mySystem.customOptions.nixos.currentChannelInUse = {
    type = lib.types.enum [
      "pkgs"
      "pkgsUnstable"
    ];
    default = null;
    description = "What channel to use for NixOS  base system, packages overrides and supporting packages.";
  };
}
