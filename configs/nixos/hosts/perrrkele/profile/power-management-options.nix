{
  ...
}:
{
  # TLP
  services.tlp.enable = false; # I'm using auto-cpufreq

  mySystem = {

    # Auto-cpufreq
    programs.auto-cpufreq.enable = true;

    powerManagement.enable = true;
    services.thermald.enable = true;
  };
}
