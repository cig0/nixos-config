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
    default = null; # Let's explicitly set this option in our host-options.nix module
    description = "Channel to use for the NixOS base system, package overrides, and supporting packages.";
  };
}
