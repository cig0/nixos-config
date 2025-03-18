{
  lib,
  ...
}:
let
  moduleLoader = import ../../lib/module-loader.nix { inherit lib; };
  
  # Get the directory of this file
  dir = ./.;
  
  # Collect all home-manager modules
  modules = moduleLoader.collectModules {
    inherit dir;
    excludePaths = [
      "applications/zsh/aliases"
      "applications/zsh/functions"
    ];
  };
in
{
  imports = builtins.filter (x: x != null) modules;
}
