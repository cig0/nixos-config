# TODO: Add description of the module to the rest of the default.nix modules.

/*
  This module is a sidecar of `module-loades`:
  - Defines what directories `module-loader` will recursively scan; the default value is `dir = ./.`
  - Allows to exclude directories
  - Allows to import specific modules. This is specially useful when you have to exclude a path, but
  still want to import some of the modules from there.

  Running `module-loader` from a different location by declaring a different path for `dir` may
  cause unexpected behavior. I performed some simple tests and everything worked as expected, yet
  that deviates from the original design idea for `module-loader`.

  For more details, see the README.md.
*/
{ config, lib, ... }:
let
  moduleLoader = import ../../../lib/module-loader/lib.nix { inherit lib; };

  # Define the directory root to search for modules
  dir = ./.;

  # Collect NixOS modules
  modules = moduleLoader.collectModules {
    inherit dir;

    # Files and directories to exclude. Use this list to exclude specific modules too.
    excludePaths = [ "applications/zsh" ];
  };
in
{
  # Cherry-pick modules to import here from excluded directories
  imports = builtins.filter (x: x != null) modules ++ [
    ./applications/zsh/zsh.nix
    # (import ./environment/session.nix { inherit config lib; }) # Shared modules
  ];
}
