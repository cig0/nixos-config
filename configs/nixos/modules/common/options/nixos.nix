{
  lib,
  ...
}:
{
  options.mySystem.myOptions.nixos = {
    channelPkgs = lib.mkOption {
      type = lib.types.enum [
        "stable"
        "unstable"
      ];
      description = "Channel to use for the NixOS base system, package overrides, and supporting packages.";
    };

    flake.path = lib.mkOption {
      type = lib.types.path;
      default = "/etc/nixos/nixos-config";
      description = "The path that will be used for the `FLAKE` environment variable.";
    };
  };
}
