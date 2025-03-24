{
  config,
  lib,
  ...
}:
{
  options.mySystem.myModuleArgs = lib.mkOption {
    type = lib.types.attrsOf lib.types.attrs; # Flexible attributes set
    default = { };
    description = "Contributions to _module.args.myArgs from modules";
  };

  config._module.args.myArgs = config.mySystem.myModuleArgs;
}
