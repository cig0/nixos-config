{
  lib,
  ...
}:
{
  options.mySystem.customOptions.nixos.channelPkgs = lib.mkOption {
    type = lib.types.enum [
      "pkgs"
      "pkgsUnstable"
    ];
    description = "Channel to use for the NixOS base system, package overrides, and supporting packages.";
  };
}
