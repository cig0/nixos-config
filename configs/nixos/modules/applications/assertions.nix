{
  config,
  lib,
  ...
}:
{
  assertions = [
    {
      # tmux.nix
      assertion = !(config.myNixos.programs.tmux.enable && config.myNixos.myOptions.packages.tmux.enable);
      message = "Only one of `myNixos.programs.tmux.enable` or `myNixos.myOptions.packages.tmux.enable` can be enabled at a time.";
    }

    {
      # yazi.nix
      assertion = (
        if config.programs.yazi.enable && !config.myNixos.programs.yazi.enable then
          builtins.trace "Warning: programs.yazi.enable is true but was not set through myNixos.programs.yazi.enable" false
        else
          lib.count (x: x) [
            (config.programs.yazi.enable && !config.myNixos.programs.yazi.enable)
            config.myNixos.package.yazi.enable
            config.myNixos.programs.yazi.enable
          ] <= 1
      );
      message = "Only one of `config.programs.yazi.enable` (not through myNixos), `config.myNixos.package.yazi.enable`, or `config.myNixos.programs.yazi.enable` can be enabled at a time.";
    }
  ];
}
