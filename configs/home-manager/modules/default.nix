{
  lib,
  ...
}:
let
  moduleLoader = import ../../../lib/module-loader/lib.nix { inherit lib; };

  /*
    This module performs a recursive directory scan and should be initialized from its own directory,
    unless explicitly overridden.

    Initializing it from a different location may cause unexpected behavior by deviating from the
    module's intended design.

    For more details, see README.md.
  */

  # Define the directory root to search for modules
  dir = ./.;

  # Collect NixOS modules
  modules = moduleLoader.collectModules {
    inherit dir;

    # Files and directories to exclude. Use this list to exclude specific modules too.
    excludePaths = [
      "applications/zsh"
    ];
  };
in
{
  # TODO_ Add description to template file, replicate changes
  # You can cherry-pick modules to import here from excluded directories
  imports = builtins.filter (x: x != null) modules ++ [
    ./applications/zsh/zsh.nix
  ];
}
