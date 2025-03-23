{
  config,
  lib,
  pkgsUnstable,
  ...
}:
{
  config = lib.mkIf (config.mySystem.myOptions.hardware.gpu == "intel") {

    # Additional module packages
    mySystem.myOptions.packages.modulePackages = with pkgsUnstable; [
      nvtopPackages.intel
    ];
  };
}
