# Don't remove this line! This is a NixOS hardware module.

{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "programs" "auto-cpufreq"] config;
in {
  imports = [inputs.auto-cpufreq.nixosModules.default];

  options.mySystem.programs.auto-cpufreq.enable =
    lib.mkEnableOption "Whether to enable auto-cpufreq daemon.";

  config = lib.mkIf cfg.enable {
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

    services.power-profiles-daemon.enable = false; # Used by GUI shells, like KDE. Needs to be disable as it interferes with auto-cpufreq.
  };
}
