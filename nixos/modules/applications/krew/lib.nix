{ lib, ... }:
{
  options.mySystem.lib.krew = lib.mkOption {
    type = lib.types.submodule {
      options = {
        installPlugins = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "List of Krew plugins to install";
          internal = true;
        };
      };
    };
    default = { };
    description = "Krew library functions and values";
  };
}
