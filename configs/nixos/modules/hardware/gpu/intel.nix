{
  config,
  lib,
  myArgs,
  ...
}:
{
  config = lib.mkIf (config.mySystem.myOptions.hardware.gpu == "intel") {

    # Additional module packages
    mySystem.myOptions.packages.modulePackages = with myArgs.packages.pkgsUnstable; [
      nvtopPackages.intel
    ];
  };
}
