{
  lib,
  ...
}:
let
  moduleLoader = import ../../../lib/module-loader.nix { inherit lib; };

  /*
    Get the directory of this module.

    This module performs recursive directory scanning and should always be initialized from its own
    directory unless intentionally overridden. Scanning a different location may cause unintended
    behavior, as it deviates from the module's intended design.
  */
  dir = ./.;

  # Collect NixOS modules
  modules = moduleLoader.collectModules {
    inherit dir;

    # Files and directories to exclude. Use this list to exclude specific modules too.
    excludePaths = [
    ];
  };
in
{
  imports = builtins.filter (x: x != null) modules;
}
