{
  lib,
  ...
}:
{
  # Custom hardware configuration options.
  #
  # Defines the CPU and GPU types for the host system, enabling modules such as
  # environment variables, hardware acceleration, and kernel settings to access
  # this information easily.

  # It can be used as follows:
  # let
  #   cfg = {
  #     cpu = config.mySystem.customOptions.hardware.cpu;
  #     gpu = config.mySystem.customOptions.hardware.gpu;
  #   };
  # in

  options.mySystem.customOptions.hardware = {
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
}
