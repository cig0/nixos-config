{
  lib,
  ...
}:
let
  moduleLoader = import ../../../../lib/module-loader.nix { inherit lib; };

  # Get the directory of this file
  dir = ./.;

  # Collect Home Manager modules
  modules = moduleLoader.collectModules {
    inherit dir;
    # Files and directories to exclude
    excludePaths = [
    ];
  };
in
{
  imports = builtins.filter (x: x != null) modules ++ [
  ];
}
