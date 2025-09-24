{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixos.console.keyMap;
in
{
  options.myNixos.console.keyMap = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = "us-acentos";
    description = "Set console key layout";
  };

  config = {
    console.keyMap = cfg;
  };
}
