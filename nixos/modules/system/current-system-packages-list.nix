{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.current-system-packages-list;

in {
  options.mySystem.current-system-packages-list = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Create a list of the installed packages in `/etc/current-system-packages`.";
  };

  config = lib.mkIf (cfg == true) {
    environment.etc."current-system-packages-list".text =
      let
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