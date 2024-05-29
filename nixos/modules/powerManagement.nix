# Energy saver
{ ... }:

{
  powerManagement.enable = true;
  services.thermald.enable = true;

  # Flake configuration
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
}