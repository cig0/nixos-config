{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "current-system-packages-list"] config;
in {
  options.mySystem.current-system-packages-list.enable = lib.mkEnableOption "Create a list of the installed packages in `/etc/current-system-packages`.";

  config = lib.mkIf cfg.enable {
    environment.etc."current-system-packages-list".text = let
      packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
      sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
      formatted;
  };
}
# READ ME!
# ========
# I can't remember where I took this bit from :/

