{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.mySystem.programs.nh;
in {
  options.mySystem.programs.nh = {
    enable = lib.mkEnableOption "Whether to enable nh, yet another Nix CLI helper.";
    clean.enable = lib.mkEnableOption "Whether to enable periodic garbage collection with nh clean all.";
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;

      # TODO: check config.nix.gc.enable = false;
      clean = {
        enable = false;
        dates = "weekly";
        extraArgs = "--keep 5";
      };
      flake = inputs.self.outPath; # Use as input the flake of the current system.
    };
  };
}
# READ ME!
# ========
# nh: Yet another nix cli helper.
# Refs: https://github.com/viperML/nh (don't forget to star it!)
# This configuration is an alternative way to keep a system updated.
# You should have only one updater enabled at a time.

