{ config, lib, inputs, ... }:

let
  cfg = config.mySystem.programs.auto-cpufreq.enable;

in {
  imports = [ inputs.auto-cpufreq.nixosModules.default ];

  options.mySystem.programs.auto-cpufreq.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable auto-cpufreq";
  };

  config = lib.mkIf (cfg == true) {
    programs.auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
        };
        battery = {
          governor = "powersave";
          turbo = "auto";
        };
      };
    };

    services.power-profiles-daemon.enable = false;  # Used by GUI shells, like KDE. Needs to be disable as it interferes with auto-cpufreq.
  };
}