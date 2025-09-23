# I can't remember where I took this bit from :/
{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.myNixos.myOptions.current-system-packages-list.enable =
    lib.mkEnableOption "Create a file with the list of the installed packages in `/etc/current-system-packages`.";

  config = lib.mkIf config.myNixos.myOptions.current-system-packages-list.enable {
    environment.etc."current-system-packages-list".text =
      let
        packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
        sortedUnique = builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
        formatted = builtins.concatStringsSep "\n" sortedUnique;
      in
      formatted;
  };
}
