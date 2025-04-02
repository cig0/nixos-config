{
  lib,
  ...
}:
{
  options.mySystem.myOptions.nixos = {
    flakePath = lib.mkOption {
      type = lib.types.path;
      default = "/etc/nixos/";
      description = "The path for the flake source code.";
    };
  };
}
