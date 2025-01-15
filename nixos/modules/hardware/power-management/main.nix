{
  imports = builtins.filter (x: x != null) [
  ./auto-cpufreq.nix
  ./power-management.nix
  ];
}