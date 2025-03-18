{
  lib,
  ...
}:
let
  moduleLoader = import ../../../lib/module-loader.nix { inherit lib; };

  # Collect NixOS modules
  modules = moduleLoader.collectModules {
    # Files and directories to exclude
    excludePaths = [
    ];
  };
in
{
  imports = builtins.filter (x: x != null) modules;
}
