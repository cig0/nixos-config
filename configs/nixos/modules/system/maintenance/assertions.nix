{
  config,
  lib,
  ...
}:
{
  assertions = [
    {
      # nix-store.nix
      assertion = !(config.myNixos.nix.gc.automatic && config.myNixos.programs.nh.clean.enable);
      message = "Only one of `myNixos.nix.gc.automatic` or `myNixos.programs.nh.clean.enable` can be enabled at a time.";
    }
  ];
}
