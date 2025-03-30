{
  ...
}:
{
  services.tlp.enable = false; # I'm using auto-cpufreq

  mySystem = {
    programs.auto-cpufreq.enable = true;
    powerManagement.enable = true;
    services.thermald.enable = true;
  };
}
