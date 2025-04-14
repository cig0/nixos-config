{
  lib,
  ...
}:
{
  options.myNixos.myOptions = {
    flakePath = lib.mkOption {
      type = lib.types.path;
      default = "/etc/nixos/";
      description = "The path for the flake source code.  A handy option for use with shell aliases and functions.";
    };
  };
}
