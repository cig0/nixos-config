{ pkgsUnstable, ... }:
{
  config.mySystem.lib = {
    modulePackages = [ pkgsUnstable.ranger ];
  };
}
