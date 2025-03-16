{
  lib,
  ...
}:
{
  options.mySystem.myOptions.nixos.channelPkgs = lib.mkOption {
    type = lib.types.enum [
      "stable"
      "unstable"
    ];
    description = "Channel to use for the NixOS base system, package overrides, and supporting packages.";
  };
}
