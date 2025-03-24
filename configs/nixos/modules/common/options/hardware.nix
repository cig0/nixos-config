{
  config,
  lib,
  ...
}:
{
  options.mySystem.myOptions.hardware = {
    cpu = lib.mkOption {
      type = lib.types.enum [
        "amd"
        "arm"
        "intel"
      ];
      description = "The CPU type of the host system";
    };

    gpu = lib.mkOption {
      type = lib.types.enum [
        "amd"
        "intel"
        "nvidia"
      ];
      description = "The GPU type of the host system";
    };
  };

  config = {
    mySystem.myModuleArgs.hardware = {
      cpuType.isIntelCpu = config.mySystem.myOptions.hardware.cpu == "intel";
      gpuType = {
        isIntelGpu = config.mySystem.myOptions.hardware.gpu == "intel";
        isNvidiaGpu = config.mySystem.myOptions.hardware.gpu == "nvidia";
      };
    };
  };
}
