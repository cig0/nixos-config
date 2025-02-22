{
  config,
  lib,
  ...
}:
{
  options.mySystem.programs.krew = {
    enable = lib.mkEnableOption "Whether to enable and manage Krew, a package manager for kubectl plugins.";
    install = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "A list of plugins to install.";
      example = [
        "ktop"
        "slowdrain"
      ];
    };
  };

  config = lib.mkIf config.mySystem.programs.krew.enable {
    mySystem.programs.krew.install = config.mySystem.programs.krew.install;
  };
}
