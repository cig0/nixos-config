{
  lib,
  ...
}:
{
  options.myNixos = {
    myOptions.hardware = {
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

    hardware.graphics.enable = lib.mkEnableOption ''
      Whether to enable hardware accelerated graphics drivers.

      This is required to allow most graphical applications and environments to use hardware rendering, video encode/decode acceleration, etc.

      This option should be enabled by default by the corresponding modules, so you do not usually have to set it yourself.
    '';
  };
}
