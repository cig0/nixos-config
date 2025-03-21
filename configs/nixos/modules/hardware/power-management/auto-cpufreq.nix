{
  config,
  lib,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "mySystem" "programs" "auto-cpufreq" ] config;
in
{
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

    /*
      Used by GUI shells, like KDE.
      It has to be disable as it interferes with auto-cpufreq.
    */
    services.power-profiles-daemon.enable = false;
  };
}
