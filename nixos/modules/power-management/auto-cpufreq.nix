{ ... }:

{
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
  services.power-profiles-daemon.enable = false; # Needs to be disable as it interferes with auto-cpufreq.
}