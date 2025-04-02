{
  ...
}:
{
  # TLP
  services.tlp.enable = false; # I'm using auto-cpufreq

  mySystem = {
    # auto-cpufreq
    programs.auto-cpufreq.enable = true;

    # NixOS built-ins
    powerManagement.enable = true;
    services.thermald.enable = true;
  };
}
