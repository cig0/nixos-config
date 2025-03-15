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
    default = "pkgs";
    description = "The CPU type of the host system";
  };
}
