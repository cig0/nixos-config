{
  lib,
  ...
}:
let
  moduleLoader = import ../../lib/module-loader.nix { inherit lib; };
  
  # Get the directory of this file
  dir = ./.;
  
  # Collect all NixOS modules
  modules = moduleLoader.collectModules {
    inherit dir;
    excludePaths = [
    ];
  };
in
{
  imports = builtins.filter (x: x != null) modules;
}
